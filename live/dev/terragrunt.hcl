#CONFIGURATION FOR SIMPLE NULL RESOURCE - DEV

/*terraform {
  source = "../../modules/null_resource"
}

inputs = {
  environment = " dev"
}*/

# repro/terragrunt.hcl

terraform {
  # Remote source — this is the critical condition.
  # Scalr writes scalr_override.tf.json into the run working dir,
  # but OpenTofu executes from .terragrunt-cache/<hash>/repo-contents/
  # so the override file is never on OpenTofu's load path.
 source = "tfr://registry.terraform.io/terraform-aws-modules/vpc/aws?version=5.1.0"
}

inputs = {
  environment = " dev"
}

# No generate "provider" block here — mirrors what the customer confirmed:
# Terragrunt does not emit the provider block when running on Scalr runners.

#CONFIGURATION FOR CREATION AWS S# BUCKET - DEV

/*terraform {
  source = "../../modules/s3_bucket"
}

inputs = {
  bucket_name = "dev-my-unique-bucket"
  versioning  = false
  encryption  = false
}*/


