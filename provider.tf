terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.my_bucket.id
    key            = "terraform.tfstate"
    region         = var.region
    dynamodb_table = aws_dynamodb_table.my_table.name
  }
}