provider "aws" {
  region     = "us-west-2"
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  versioning {
    enabled = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encryption ? "AES256" : null
    }
  }
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}
