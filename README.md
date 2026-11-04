AWS Infrastructure Provisioning with Terraform

A hands-on Infrastructure as Code (IaC) project that provisions a basic AWS environment using Terraform.
Based on HashiCorp's "Get Started - AWS" series of tutorials (https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

Overview

This project demonstrates the provision of a basic AWS infrastructure using Terraform following IaC principles.

The infrastructure provides a custom Virtual Private Cloud (VPC), public and private subnets, and Internet Gateway, security groups, and an EC2 instance running Ubuntu 24.04.

The project is designed to be reusable and configurable through Terraform input variables.

Architecture

(Mermaid)

The infrastructure consists of:
- VPC: Custom network with CIDR 10.0.0.0/16.
- Public subnet: Hosts the EC2 instance and provides internet connectivity through an Internet Gateway.
- Private subnets: Two isolated subnets distributed across Availability Zones.
- Internet Gateway: Enables internet connectivity for resource in the public subnet.
- Security Group: Controls inbound SSH access and outbound traffic.
- EC2 instance: Ubunto 24.04 running on a t3.micro instance

Technologies

- AWS
- Terraform
- AWS CLI
- Linux/Ubuntu
- Git & Github (version control)

Repository Structure

lab01/
    main.tf                    // Main Terraform configuration that provisions infrastructure from AWS, creates SSH keys, creates security group, ingress and egress rules.
    variables.tf               // Terraform variable declarations.
    outputs.tf                 // After infrastructure has been provisioned successfully, outputs.tf will print the EC2 instance's Public DNS and IP.
    terraform.rf               // Terraform configuration declaring required provider versions for aws provider and Terraform itself.
    terraform.tfvars.example   // Sample file declaring the values of variables on variables.tf including AWS profile and region, SSH keys directory and Public IP to SSH from into the EC2 instance.
    .gitignore
    README.md

Prerequisites

Before deploying this infrastructure, make sure have:
- An AWS account.
- AWS CLI installed and configured.
- Terraform installed.
- An SSH key pair.
- Appropriate AWS IAM permissions to provision the required resources.

Configuration:

Clone the repository:
    (SSH)
    git clone git@github.com:danmbel15/lab01.git
    (HTTPS)
    git clone github.com/dambel15/lab01.git

    cd lab 01

Create your local variables file:
    cp terraform.tfvars.example terraform.tfvars

Edit "terraform.tfvars" and configure your own values, including:
- AWS Region
- Availability Zones
- EC2 instance type.
- Public IP address authorized for SSH access.
- Path to your SSH public key.
- EC2 Key Pair name.

Configure your AWS credentials separately using the AWS CLI. DO NOT store AWS credentials in Terraform variable files.

Deployment

Initialize Terraform:
    terraform init

Format and validate the configuration:
    terraform fmt -check
    terraform validate

Review the execution plan:
    terraform plan

Deploy the infrastructure:
    terraform apply

Double-check the execution plan and apply typing 'yes'.

Terraform will display the outputs defined in the configuration 'outputs.tf', including the EC2 instance's public IP address and public DNS name.

Connecting to the EC2 instance

Use the private SSH key associated with the public key configured in 'terraform.tfvars':
    ssh -i ~/.ssh/terraform-lab ubuntu@<PUBLIC_IP>

Replace <PUBLIC_IP> with the public IP returned by Terraform.

Cleanup

To avoid unnecessary AWS charges, destroy the infrastructure when it is no longer needed:
    terraform destroy

Review the proposed changes and confirm the operation typing 'yes'.

Security Considerations:
- SSH access is restricted to a specific public IP address using a /32 CIDR block. (ssh_cidr.var)
- AWS credentials are managed separately from Terraform configuration files.
- Private SSH keys are never stored in the repository.
- Local Terraform state and variable files are excluded through '.gitignore'
- No NAT gateway is provisioned in this lab.

Future Improvements:
- Implement automated Terraform validation using GitHub Actions.
- Improve variable validation and configuration flexibility.
- Integrate configuration management using Ansible.
