output "id" {
  value = module.emr.id
}

output "name" {
  value = module.emr.name
}

output "master_public_dns" {
  value = module.emr.master_public_dns
}

output "master_ui_url" {
  value = module.load-balancer.master_lb
}