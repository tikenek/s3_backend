provider "aws" {
  version                 = "~> 4.0"
  shared_credentials_file = "~/.aws/credentials"
  region                  = var.region
}
