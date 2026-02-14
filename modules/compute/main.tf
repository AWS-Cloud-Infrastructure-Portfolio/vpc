############################################
# AMI Lookup
############################################

data "aws_ssm_parameter" "al2023_latest" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

############################################
# Key Pair
############################################

resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  key_name   = "lab-bastion-key"
  public_key = tls_private_key.bastion.public_key_openssh
  tags       = var.common_tags
}

############################################
# Security Groups
############################################

resource "aws_security_group" "bastion" {
  name   = "lab-bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "lab-bastion-sg"
  })
}

resource "aws_security_group" "private" {
  name   = "lab-private-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "lab-private-sg"
  })
}

############################################
# EC2 Instances
############################################

resource "aws_instance" "bastion" {
  ami                         = data.aws_ssm_parameter.al2023_latest.value
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  key_name                    = aws_key_pair.bastion.key_name
  associate_public_ip_address = true

  tags = merge(var.common_tags, {
    Name = "lab-bastion"
  })
}

resource "aws_instance" "app" {
  ami                         = data.aws_ssm_parameter.al2023_latest.value
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.private.id]
  key_name                    = aws_key_pair.bastion.key_name
  associate_public_ip_address = false

  tags = merge(var.common_tags, {
    Name = "lab-app"
  })
}

