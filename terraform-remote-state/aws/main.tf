# Simple S3 bucket to test remote state
resource "aws_s3_bucket" "demo" {
  bucket = "demo-bucket-${random_string.suffix.result}"
  
  tags = {
    Purpose    = "remote-state-testing"
    ManagedBy  = "terraform"
    Backend    = "s3-dynamodb"
  }
}

# Enable versioning on demo bucket
resource "aws_s3_bucket_versioning" "demo" {
  bucket = aws_s3_bucket.demo.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}