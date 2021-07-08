provider "aws" {
  region = "eu-west-1"
}

module "logging_bucket" {
  source = "./../../"

  name        = "test-loging  "
  environment = "test"
  attributes  = ["public"]
  label_order = ["name", "environment", "attributes"]
  acl         = "log-delivery-write"
}


module "s3_bucket" {
  source = "./../../"

  name        = "clouddrove-logging-encryption-bucket"
  environment = "test"
  attributes  = ["public"]
  label_order = ["name", "environment"]

  versioning    = true
  acl           = "private"
  sse_algorithm = "AES256"
  logging       = { target_bucket : module.logging_bucket.id, target_prefix = "logs" }

  depends_on = [module.logging_bucket]
}
