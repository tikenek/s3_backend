resource "aws_s3_bucket" "my_bucket" {
  bucket = "sandbox-vpc-tynar-s3-backend"
  #   region = "us-east-1" 
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }

  #This step should pick up the existing vpc module
  # vpc_configuration {
  #   vpc_id = module.vpc.vpc_id
  # }

  tags = var.tags
}


resource "aws_s3_bucket_versioning" "my_bucket" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = var.versioning_configuration
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}