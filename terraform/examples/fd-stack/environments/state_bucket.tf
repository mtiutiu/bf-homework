# TF state S3 bucket configuration
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform"

  # Prevent accidental deletion of the TF state bucket
  lifecycle {
    prevent_destroy = true
  }
}

# Enable TF state S3 bucket versioning
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
