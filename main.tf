provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  common_tags         = local.common_tags
}

module "compute" {
  source = "./modules/compute"

  vpc_id            = module.network.vpc_id
  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
  allowed_ssh_cidr  = var.allowed_ssh_cidr
  instance_type     = var.instance_type
  common_tags       = local.common_tags
}
