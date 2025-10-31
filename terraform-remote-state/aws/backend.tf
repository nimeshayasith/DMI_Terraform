terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
  
  backend "s3" {
    bucket         = "tfstate-backend-ny-1761670941"  # Replace with your bucket
    key            = "aws-demo/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
    
    # Authentication via AWS credentials in ~/.aws/credentials
    # Or AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables
  }
}

provider "aws" {
  region = "us-east-1"
}