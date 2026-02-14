variable "region" {
  type        = string
  description = "AWS region"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "admin_ip" {
  type        = string
  description = "Admin IP allowed to SSH (format: x.x.x.x/32)"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
