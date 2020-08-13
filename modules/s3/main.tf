resource "aws_s3_bucket" "create_bucket_bootstrap" {
  bucket = "${var.name}-bootstrap-volume"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_logs_bucket.id
  }

  tags = {
    Name        = "Bucket for EMR Bootstrap actions/Steps"
    Environment = "Scripts"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_object" "bootstrap_action_file" {
  bucket     = "${var.name}-bootstrap-volume"
  key        = "scripts/bootstrap_actions.sh"
  source     = "scripts/bootstrap_actions.sh"
  depends_on = [aws_s3_bucket.create_bucket_bootstrap]
}

resource "aws_s3_bucket_object" "pyspark_quick_setup_file" {
  bucket     = "${var.name}-bootstrap-volume"
  key        = "scripts/pyspark_quick_setup.sh"
  source     = "scripts/pyspark_quick_setup.sh"
  depends_on = [aws_s3_bucket.create_bucket_bootstrap]
}

resource "aws_s3_bucket" "create_bucket_jupyter_persistent" {
  bucket = "${var.name}-persistent-storage"
  acl    = "private"
  force_destroy = true

  logging {
    target_bucket = aws_s3_bucket.s3_logs_bucket.id
  }

  tags = {
    Name        = "Bucket for Jupyterhub Persistent Storage"
    Environment = "Scripts"
  }

  lifecycle {
    create_before_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "emr_logs_bucket" {
  bucket = "${var.name}-cluster-logs"
  acl    = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.s3_logs_bucket.id
  }

  lifecycle {
    create_before_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "s3_logs_bucket" {
  bucket = "${var.name}-s3logs"
  acl    = "log-delivery-write"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle {
    create_before_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
