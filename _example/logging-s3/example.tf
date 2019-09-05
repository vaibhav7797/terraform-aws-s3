provider "aws" {
  region = "eu-west-1"
}

module "s3_bucket" {
  source = "git::https://github.com/clouddrove/terraform-aws-s3.git?ref=tags/0.12.1"

  name        = "logging-bucket"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "name", "application"]

  region                 = "eu-west-1"
  versioning             = true
  acl                    = "private"
  bucket_logging_enabled = true

  target_bucket = "bucket-logs12"
  target_prefix = "logs"
}