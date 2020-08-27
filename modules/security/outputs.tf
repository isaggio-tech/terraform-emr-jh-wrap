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
 
output "ec2_key_pair_fingerprint" {
  description = "The MD5 public key fingerprint as specified in section 4 of RFC 4716."
  value       = "${aws_key_pair.generated_key.fingerprint}"
}

output "ec2_key_pair_id" {
  value       = "${aws_key_pair.generated_key.id}"
}
