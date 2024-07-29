provider "aws" {
  region                  = local.aws_region
  skip_metadata_api_check = true
}

terraform {
  required_version = ">= 1.9.1" # Specify the required Terraform version as needed

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60.0" # Specify the version constraint as needed
    }
  }
}