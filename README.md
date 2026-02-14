# AWS Secure VPC Architecture (Terraform – Modularized)

Production-style AWS VPC deployment using Terraform, implementing secure network segmentation, controlled ingress/egress, and modular infrastructure design.

---

## Overview

This project demonstrates the design and deployment of a secure AWS network architecture using a modular Terraform structure.

It includes:

- Public and private subnets
- Internet Gateway and NAT Gateway
- Bastion host for controlled administrative access
- Private EC2 instance with no public exposure
- Security groups enforcing least-privilege access
- Parameterized Terraform configuration
- Centralized tagging strategy
- Clean provisioning and teardown lifecycle

The infrastructure is fully automated and designed to be reproducible and reusable.

---

## Architecture Design

### Network Layer (Module: `network`)
- Custom VPC
- Public subnet (internet-facing)
- Private subnet (isolated)
- Internet Gateway
- NAT Gateway for outbound-only internet access
- Dedicated route tables

### Compute Layer (Module: `compute`)
- Bastion host in public subnet
- Private application instance
- Security group referencing (bastion → private)
- SSH restricted to a configurable `admin_ip`
- AMI dynamically retrieved via AWS SSM Parameter Store

---

## Terraform Structure

root/
├── main.tf      # Orchestrates modules
├── variables.tf # Input variables
├── locals.tf    # Standardized tagging
├── outputs.tf   # Exposed outputs
├── versions.tf  # Provider/version constraints
└── modules/
├── network/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
└── compute/
  ├── main.tf
  ├── variables.tf
  └── outputs.tf

  
The root module orchestrates infrastructure by passing outputs from the network module into the compute module.

Terraform establishes dependencies automatically through output references, ensuring that the network layer is provisioned before compute resources.

---

## Security Considerations

- Private EC2 instance has no public IP  
- SSH access restricted via `admin_ip` variable  
- Security group referencing instead of CIDR-based internal access  
- Controlled outbound access through NAT Gateway  
- Infrastructure deployed with standardized tagging  

Potential production enhancements:

- Multi-AZ high availability  
- Replacing bastion host with SSM Session Manager  
- Remote Terraform backend using S3 with DynamoDB state locking  
- Centralized logging and monitoring integration  

---

## Deployment Instructions

1. Configure AWS credentials.  
2. Create a `terraform.tfvars` file:

```hcl
region               = "us-east-1"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidr   = "10.0.1.0/24"
private_subnet_cidr  = "10.0.2.0/24"
availability_zone    = "us-east-1a"
admin_ip             = "YOUR_PUBLIC_IP/32"
instance_type        = "t3.micro"

3. Initialize Terraform:
terraform init

4. Review the execution plan:
terraform plan

5. Apply the configuration:
terraform apply

6. Destroy infrastructure when finished:
terraform destroy

---

## Key Concepts Demonstrated

- Modular Terraform architecture
- Infrastructure parameterization
- Implicit dependency management
- Secure VPC segmentation design
- Bastion-based administrative access pattern
- Idempotent infrastructure provisioning

---

## Author

Sebastian Silva C.
Cloud Engineer – Secure Infrastructure & Automation
Berlin, Germany
