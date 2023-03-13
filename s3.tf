resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  region = var.region

  vpc_configuration {
    vpc_id = module.vpc.vpc_id
  }
}