# variable "vpc_id" {
#   type = string
# }

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type    = string
  default = "sandbox_vpc_tynar_s3_backend"
}

variable "versioning_configuration" {
  type    = string
  default = "Enabled"
}

variable "dynamodb_table_name" {
  type    = string
  default = "Sandbox_vpc_tynar_dynamodb"
}

variable "tags" {
  description = "This is the name of the resources"
  type        = map(string)
  default = {
    "Name" = "sandbox-tynar"
  }
}