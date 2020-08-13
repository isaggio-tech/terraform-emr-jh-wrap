output "master_lb" {
  value = "${aws_lb.emr_master_lb.dns_name}"
}