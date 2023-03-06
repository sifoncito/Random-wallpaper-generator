terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region 
  shared_credentials_files = ["$HOME/.aws/credentials"]
}