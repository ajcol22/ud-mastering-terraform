# Terraform providers block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }
}

# Resource block for an S3 bucket (managed by our Terraform script here)
resource "aws_s3_bucket" "my_bucket_ex04" {
  bucket = var.bucket_name
}

# Data block for externally managed S3 bucket (Not managed by our TF script here, just want to use in our project)
data "aws_s3_bucket" "my_external_bucket_ex04" {
  bucket = "not-managed-by-us"
}

# Variable used to set bucket name and avoid hardcoding it
variable "bucket_name" {
  type = string
  description = "My variable used to set bucket name"
  default = "my_default_bucket_name_ex04"
}

# Outputs the ID of the bucket we are managing
output "bucket_id" {
  value = aws_s3_bucket.my_bucket_ex04.id
}

# Temporary variable used only in this code
locals {
  local_example = "This is a local variable"
}

# Module block
module "my_module_ex04" {
  source = "./module-example-ex04"
}
