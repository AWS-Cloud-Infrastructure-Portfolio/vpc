############################################
# Compute Module Variables
############################################

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for bastion host"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for application instance"
  type        = string
}

variable "admin_ip" {
  description = "Admin IP allowed to SSH into bastion (format x.x.x.x/32)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}

