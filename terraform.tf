terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.28.0, < 7.0.0" #Minimum and maximum version of the AWS provider
    }
  }

  required_version = ">= 1.7" #Minimum version of Terraform required to run this configuration

}