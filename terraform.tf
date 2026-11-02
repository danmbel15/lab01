terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.28.0, < 7.0.0" #versión mínima y máxima del proveedor de AWS
    }
  }

  required_version = ">= 1.7" #versión mínima de Terraform

}