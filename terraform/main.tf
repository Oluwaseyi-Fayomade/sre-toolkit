provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "sre_toolkit_bucket" {
  bucket = "sre-toolkit-willie-2026"

  tags = {
    Name        = "SRE Toolkit Bucket"
    Environment = "training"
    Owner       = "oluwaseyi"
    Project     = "sre-toolkit"
  }
}

resource "aws_s3_bucket_versioning" "sre_toolkit_versioning" {
  bucket = aws_s3_bucket.sre_toolkit_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}