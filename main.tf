module "s3" {
  source = "./modules/s3"
  name   = var.name
}

module "iam" {
  source              = "./modules/iam"
  name                = var.name
  emr_logs_s3         = module.s3.emr_logs_bucket
  emr_bootstrap_s3    = module.s3.emr_bootstrap_bucket
  emr_jh_persist_s3   = module.s3.emr_jh_persistent_bucket 
}

module "security" {
  source              = "./modules/security"
  name                = var.name
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
}

#module "load-balancer" {
#  source              = "./modules/load-balancer"
#  vpc_id              = var.vpc_id 
#  subnet_ids          = var.subnet_ids_lb
#  lb_security_group   = module.security.emr_lb_security_group
#  jupyter_port        = var.jupyter_hub_port
#  master_id           = module.emr.emr_master_id
#  name                = var.name
#}

module "emr" {
  source                    = "./modules/emr"
  name                      = var.name
  release_label             = var.release_label
  applications              = var.applications
  subnet_id                 = var.subnet_id
  master_instance_type      = var.master_instance_type
  master_ebs_size           = var.master_ebs_size
  core_instance_type        = var.core_instance_type
  core_instance_count       = var.core_instance_count
  core_ebs_size             = var.core_ebs_size
  emr_master_security_group = module.security.emr_master_security_group
  emr_slave_security_group  = module.security.emr_slave_security_group
  emr_ec2_instance_profile  = module.iam.emr_ec2_instance_profile
  emr_service_role          = module.iam.emr_service_role
  emr_autoscaling_role      = module.iam.emr_autoscaling_role
  emr_logs_s3               = module.s3.emr_logs_bucket
  emr_bootstrap_s3          = module.s3.emr_bootstrap_bucket
  core_instance_count_min   = var.core_instance_count_min
  core_instance_count_max   = var.core_instance_count_max
  kms_key_id                = module.iam.iam_kms_key_id
  ssh_key_name              = module.security.ec2_ssh_key
}