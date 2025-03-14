#SIMPLE AWS CONFIGURATION WITHOUT SPECIFICATION FOR DIFFERENT ENVS!
#CREATED TO CHECK PROVIDER CONFIGS CRED'S FUNCTIONALITY WITH TERRAGRUNT

provider "aws" {
  region     = "us-west-2"

}

locals {
  bucket_name         = "check-terragrunt-bucket"
  dynamodb_table_name = "check-terragrunt-table"
}

# Create the S3 bucket to store the Terraform state file
resource "aws_s3_bucket" "terraform_state" {
  bucket = local.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}

# Create a DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST" # This uses on-demand pricing for DynamoDB

  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"

  # Enable point-in-time recovery (optional)
  point_in_time_recovery {
    enabled = true
  }

  # Add a TTL to reduce storage costs for expired locks (optional)
  ttl {
    attribute_name = "TTL"
    enabled        = true
  }

  tags = {
    Name        = "TerraformLockTable"
    Environment = "dev"
  }
}