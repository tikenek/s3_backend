# module "vpc" {
#   source = ".vpc_module/modules/vpc"
#   vpc_id = var.vpc_id
#   tags                 = { Name = "sandbox-tynar-s3-backend" }
# }

# terraform {
#   backend "s3" {
#     bucket         = "sandbox-vpc-tynar-s3-backend" 
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "sandbox-vpc-tynar-dynamodb" 
#   }
# }

# terraform {
#   backend "s3" {
#     bucket         = "my-backend-bucket"
#     key            = "terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "my-lock-table"
#     role_arn       = aws_iam_role.s3_backend_role.arn
#   }
# }
