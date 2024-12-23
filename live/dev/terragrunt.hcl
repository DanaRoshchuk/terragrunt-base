#CONFIGURATION FOR SIMPLE NULL RESOURCE - DEV

terraform {
  source = "../../modules/null_resource"
}

inputs = {
  environment = " dev"
}

#CONFIGURATION FOR CREATION AWS S# BUCKET - DEV

/*terraform {
  source = "../../modules/s3_bucket"
}

inputs = {
  bucket_name = "dev-my-unique-bucket"
  versioning  = false
  encryption  = false
}*/


