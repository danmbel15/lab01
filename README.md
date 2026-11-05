# AWS Infrastructure Provisioning with Terraform

A hands-on Infrastructure as Code (IaC) project that provisions a basic AWS environment using Terraform.
Based on HashiCorp's [Get Started - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started) series of tutorials.

## Overview

This project demonstrates the provision of a basic AWS infrastructure using Terraform following IaC principles.

The infrastructure provides a custom Virtual Private Cloud (**VPC**), public and private subnets, and Internet Gateway, security groups, and an EC2 instance running **Ubuntu 24.04**.

The project is designed to be reusable and configurable through Terraform input variables.

## Architecture

```mermaid
flowchart TB
    Internet((Internet))

    subgraph AWS["AWS Cloud"]
        subgraph VPC["VPC - 10.0.0.0/16"]

            IGW["Internet Gateway"]

            subgraph Public["Public Subnet - 10.0.101.0/24"]
                SG["Security Group<br/>Ubuntu 24.04<br/>t3.micro"]
            end

            subgraph PrivateA["Private Subnet - 10.0.1.0/24"]
                PA[Private Resources]
            end

            subgraph PrivateB["Private Subnet - 10.0.2.0/24"]
                PB["Private Resources]
            end
    end
end

Internet <--> IGW
IGW --> Public
SG --> EC2

style Internet fill:#dbeafe,stroke:#2563eb,color:#1e3a8a
style EC2 fill:#dcfce7,stroke:#16a34a,color:#14532d
```

### The infrastructure consists of:
- **VPC**: Custom network with CIDR 10.0.0.0/16.
- **Public subnet**: Hosts the EC2 instance and provides internet connectivity through an Internet Gateway.
- **Private subnets**: Two isolated subnets distributed across Availability Zones.
- **Internet Gateway**: Enables internet connectivity for resource in the public subnet.
- **Security Group**: Controls inbound SSH access and outbound traffic.
- **EC2 instance**: Ubuntu 24.04 running on a <code>t3.micro</code> instance

### Technologies

- AWS
- Terraform
- AWS CLI
- Linux/Ubuntu
- Git & Github (version control)

### Prerequisites

Before deploying this infrastructure, make sure have:
- An AWS account.
- AWS CLI installed and configured.
- Terraform installed.
- An SSH key pair.
- Appropriate AWS IAM permissions to provision the required resources.

### Configuration:

#### Clone the repository:
    # SSH
    git clone git@github.com:danmbel15/lab01.git
    # HTTPS
    git clone github.com/dambel15/lab01.git

    cd lab 01

#### Create your local variables file:
    cp terraform.tfvars.example terraform.tfvars

Edit "terraform.tfvars" and configure your own values, including:
- AWS Region
- Availability Zones
- EC2 instance type.
- Public IP address authorized for SSH access.
- Path to your SSH public key.
- EC2 Key Pair name.

Configure your AWS credentials separately using the AWS CLI. **DO NOT** store AWS credentials in Terraform variable files.

### Deployment

#### Initialize Terraform:
    terraform init

#### Format and validate the configuration:
    terraform fmt -check
    terraform validate

#### Review the execution plan:
    terraform plan

#### Deploy the infrastructure:
    terraform apply

Double-check the execution plan and apply typing '*yes*'.

Terraform will display the outputs defined in the configuration <code>outputs.tf</code>, including the EC2 instance's public IP address and public DNS name.

#### Connecting to the EC2 instance

##### Use the private SSH key associated with the public key configured in <code>terraform.tfvars</code>:
    ssh -i ~/.ssh/terraform-lab ubuntu@<PUBLIC_IP>

Replace <PUBLIC_IP> with the public IP returned by Terraform.

### Cleanup

#### To avoid unnecessary AWS charges, destroy the infrastructure when it is no longer needed:
    terraform destroy

Review the proposed changes and confirm the operation typing '*yes*'.

## Security Considerations:
- SSH access is restricted to a specific public IP address using a /32 CIDR block. <code>ssh_cidr.var</code>
- AWS credentials are managed separately from Terraform configuration files.
- Private SSH keys are never stored in the repository.
- Local Terraform state and variable files are excluded through <code>.gitignore</code>
- No NAT gateway is provisioned in this lab.

## Future Improvements:
- Implement automated Terraform validation using GitHub Actions.
- Improve variable validation and configuration flexibility.
- Integrate configuration management using Ansible.
