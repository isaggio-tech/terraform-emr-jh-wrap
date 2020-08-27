output "id" {
  value = module.emr.id
}

output "name" {
  value = module.emr.name
}

output "emr_master_dns" {
  value = module.emr.master_public_dns
}

output "current_pub_key_fingerprint" {
  value = module.security.ec2_key_pair_fingerprint
}

output "current_pub_key_id" {
  value = module.security.ec2_key_pair_id
}

output "jupyter_hub_url" {
  value = module.load-balancer.master_lb
}
