variable "name" {}
variable "subnet_id" {}
variable "key_name" {}
variable "release_label" {}
variable "applications" {
  type = list
}
variable "master_instance_type" {}
variable "master_ebs_size" {}
variable "core_instance_type" {}
variable "core_instance_count" {}
variable "core_ebs_size" {}
variable "emr_master_security_group" {}
variable "emr_slave_security_group" {}
variable "emr_ec2_instance_profile" {}
variable "emr_service_role" {}
variable "emr_autoscaling_role" {}
variable "kms_key_id" {}
variable "core_instance_count_min" {}
variable "core_instance_count_max" {}
variable "emr_bootstrap_s3" {}
variable "emr_logs_s3" {}