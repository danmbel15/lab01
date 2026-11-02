variable "ssh_cidr" {
  description = "The CIDR block for SSH access"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "The name of the instance to create"
  type        = string
  default     = "learn-terraform"
}