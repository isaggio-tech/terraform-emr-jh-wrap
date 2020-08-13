# EMR general configurations
name = "isg-emr-jupyterhub"
region = "eu-west-2"
subnet_id = "subnet-0c1d4587badb727a5"
subnet_ids_lb = ["subnet-0c1d4587badb727a5", "subnet-0b3f7f770d2f5b79a"]
vpc_id = "vpc-063d0d951c08c7792"
key_name = "isg-demo-resources-keypair"
ingress_cidr_blocks = "0.0.0.0/0"
release_label = "emr-5.30.0"
core_instance_count_min = "1"
core_instance_count_max = "3"
applications = ["Hadoop", "Spark", "JupyterHub"]

# Master node configurations
master_instance_type = "m4.xlarge"
master_ebs_size = "30"

# Slave nodes configurations
core_instance_type = "m4.large"
core_instance_count = 1
core_ebs_size = "10"

kmsTerraformMaster = "arn:aws:kms:eu-central-1:532967052392:key/5cc3733f-41e6-4e5f-b6f0-8cfdde4454a4"
profile         = "isg-terraform"
credFile        = "~/.aws/credentials"

# JupyterHub Port
jupyter_hub_port = 9443