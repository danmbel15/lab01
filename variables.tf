variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"
}

variable "availability_zones" {
  description = "The AWS availability zones to deploy resources in"
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "aws_profile" {
  description = "The AWS profile to use for authentication"
  type        = string
  default     = "default"
}

variable "public_key_path" {
  description = "The path to the public key for SSH access"
  type        = string
  default     = "~/.ssh/terraform-lab.pub"
}

variable "ssh_cidr" {
  description = "The CIDR block for SSH access"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ssh_cidr))
    error_message = "The provided ssh_cidr is not a valid IPv4 CIDR block."
  }
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