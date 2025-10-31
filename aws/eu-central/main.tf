# aws/eu-central-1/main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "assets" {
  bucket = "company-dev-assets-euc1-${random_string.suffix.result}"
  
  tags = {
    project     = "multicloud-foundation"
    owner       = "nimesha-yasith"
    environment = "dev"
    region      = "eu-central-1"
    cloud       = "aws"
  }
}

resource "aws_s3_bucket_versioning" "assets_versioning" {
  bucket = aws_s3_bucket.assets.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

output "bucket_name" {
  value = aws_s3_bucket.assets.id
}