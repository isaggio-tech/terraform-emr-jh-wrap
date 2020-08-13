data "template_file" "autoscaling_policy" {
  template = "${file("${path.module}/templates/autoscaling_policy.json.tpl")}"

  vars = {
    min_capacity = "${var.core_instance_count_min}"
    max_capacity = "${var.core_instance_count_max}"
  }
}

data "template_file" "security_configuration" {
  template = "${file("${path.module}/templates/security_configuration.json.tpl")}"

  vars = {
    kms_key_id      = "${var.kms_key_id}"
  }
}

resource "aws_emr_security_configuration" "security_configuration" {
  name = var.name

  configuration = data.template_file.security_configuration.rendered
}

resource "aws_emr_cluster" "emr_spark_cluster" {
  name                              = var.name
  release_label                     = var.release_label
  applications                      = var.applications
  log_uri       		                = "s3://${var.emr_logs_s3}/logs/"
  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
    subnet_id                         = var.subnet_id
    key_name                          = var.key_name
    emr_managed_master_security_group = var.emr_master_security_group
    emr_managed_slave_security_group  = var.emr_slave_security_group
    instance_profile                  = var.emr_ec2_instance_profile
  }

  ebs_root_volume_size = "12"

  master_instance_group {
    name           = "EMR master"
    instance_type  = var.master_instance_type
    instance_count = "1"

    ebs_config {
      size                 = var.master_ebs_size
      type                 = "gp2"
      volumes_per_instance = 1
    }
  }

  core_instance_group {
    name           = "EMR slave"
    instance_type  = var.core_instance_type
    instance_count = var.core_instance_count

    ebs_config {
      size                 = var.core_ebs_size
      type                 = "gp2"
      volumes_per_instance = 1
    }
  }

  tags = {
    Name = "${var.name} - Spark cluster"
  }

  service_role     = var.emr_service_role
  autoscaling_role = var.emr_autoscaling_role
  security_configuration = aws_emr_security_configuration.security_configuration.name

  configurations_json = <<EOF
    [
     {
        "Classification": "spark-defaults",
        "Properties": {
            "maximizeResourceAllocation": "true",
            "spark.dynamicAllocation.enabled": "true"
        }
     },
     {
        "Classification": "jupyter-s3-conf",
        "Properties": {
            "s3.persistence.enabled": "true",
            "s3.persistence.bucket": "${var.name}-persistent-storage"
        }
     }
    ]
  EOF

// Add BootStrap Actions Below,
  bootstrap_action {
    name = "Bootstrap setup."
    path = "s3://${var.name}-bootstrap-volume/scripts/bootstrap_actions.sh"
  }

// Add EMR Steps as Required,
 step {
    action_on_failure = "CONTINUE"
    name   = "Copy script file from s3."
    hadoop_jar_step {
      jar  = "command-runner.jar"
      args = ["aws", "s3", "cp", "s3://${var.name}-bootstrap-volume/scripts/pyspark_quick_setup.sh", "/home/hadoop/"]
    }
  }
  
 step {
      name              = "Setup pyspark with conda."
      action_on_failure = "CONTINUE"
      hadoop_jar_step {
        jar  = "command-runner.jar"
        args = ["sudo", "bash", "/home/hadoop/pyspark_quick_setup.sh"]
      }
  }
}

data "aws_instance" "master_dns" {
  filter {
    name   = "dns-name"
    values = ["${aws_emr_cluster.emr_spark_cluster.master_public_dns}"]
  }
}