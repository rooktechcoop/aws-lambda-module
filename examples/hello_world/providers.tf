provider "aws" {
  region = var.region
  # shared_credentials_file = var.credentials
  profile = var.profile
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14"
    }
  }
}