output "demo_bucket_name" {
  description = "Name of the demo S3 bucket"
  value       = aws_s3_bucket.demo.id
}

output "demo_bucket_arn" {
  description = "ARN of the demo S3 bucket"
  value       = aws_s3_bucket.demo.arn
}

output "backend_info" {
  description = "Backend configuration info"
  value = {
    backend_type   = "s3"
    location       = "AWS S3"
    locking        = "DynamoDB"
    lock_table     = "terraform-state-lock"
  }
}