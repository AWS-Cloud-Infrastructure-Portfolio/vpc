############################################
# Compute Module Outputs
############################################

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "app_instance_id" {
  description = "ID of the private application instance"
  value       = aws_instance.app.id
}

