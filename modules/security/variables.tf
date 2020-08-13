variable "name" {}
variable "vpc_id" {}
variable "ingress_cidr_blocks" {}
variable "ip_lookup_url" {
  default = "http://ipv4.icanhazip.com"
}
