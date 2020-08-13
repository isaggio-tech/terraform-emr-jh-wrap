variable "name" {
}

variable "region" {
}

variable "subnet_id" {
}

variable "subnet_ids_lb" {
  type = list
}

variable "vpc_id" {
}

variable "key_name" {
}

variable "release_label" {
}

variable "applications" {
  type = list(string)
}

variable "master_instance_type" {
}

variable "master_ebs_size" {
}

variable "core_instance_type" {
}

variable "core_instance_count" {
}

variable "core_ebs_size" {
}

variable "ingress_cidr_blocks" {
}

variable "kmsTerraformMaster" {
  type        = string
  description = "Terraform Service Side KMS Key ARN"
  default     = ""
}

# The initial number of instances to start
variable "core_instance_count_min" {
  default = ""
}

# The maximum number of core nodes to scale up to
variable "core_instance_count_max" {
  default = ""
}

#variable "kms_master_key_id" {
#}

variable "credFile" {
}

variable "profile" {
}

variable "emr_logs_s3" {
  default = ""  
}

variable "emr_bootstrap_s3" {
  default = ""
}

variable "jupyter_hub_port" {
}

variable "master_id" {
  default = "" 
}