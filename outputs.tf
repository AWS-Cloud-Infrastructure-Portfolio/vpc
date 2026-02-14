output "vpc_id" {
  value = module.network.vpc_id
}

output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}
