variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = list(string)
  default     = ["us-east-2", "us-east-2-a", "us-west-2-b", "us-west-2-c"]
}

variable "aws_profile" {
  description = "The AWS profile to use for authentication"
  type        = string
  default     = "terraform-lab"
}

variable "ssh_cidr" {
  description = "The CIDR block for SSH access"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "The name of the EC2 instance to create"
  type        = string
  default     = "learn-terraform"
}