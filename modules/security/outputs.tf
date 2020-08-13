output "emr_master_security_group" {
  value = "${aws_security_group.emr_master.id}"
}

output "emr_slave_security_group" {
  value = "${aws_security_group.emr_slave.id}"
}

output "emr_lb_security_group" {
  value = "${aws_security_group.lb_security_group.id}"
}

output "pub_whitelist_ip" {
  value = ["${chomp(data.http.ip.body)}/32"]
}

output "ec2_ssh_key" {
  value = "${aws_key_pair.generated_key.key_name}"
}