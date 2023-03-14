# module "vpc" {
#   source = ".vpc_module/modules/vpc"
#   vpc_id = var.vpc_id
#   tags                 = { Name = "sandbox-tynar-s3-backend" }
# }

# terraform {
#   backend "s3" {
#     bucket         = "Sandbox_vpc_tynar_s3_backend" 
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "Sandbox_vpc_tynar_dynamodb" 
#   }
# }