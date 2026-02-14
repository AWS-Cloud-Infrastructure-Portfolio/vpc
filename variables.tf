variable "region" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnet_cidr" { type = string }
variable "private_subnet_cidr" { type = string }
variable "availability_zone" { type = string }
variable "admin_ip" { type = string }
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
