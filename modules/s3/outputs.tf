output "s3_logs_bucket" {
  value = "${aws_s3_bucket.s3_logs_bucket.id}"
}

output "emr_logs_bucket" {
  value = "${aws_s3_bucket.emr_logs_bucket.id}"
}

output "emr_bootstrap_bucket" {
  value = "${aws_s3_bucket.create_bucket_bootstrap.id}"
}