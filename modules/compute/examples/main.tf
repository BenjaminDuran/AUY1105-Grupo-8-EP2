# Ejemplo funcional del módulo Compute.
# Crea la red (módulo vpc) y un security group, luego despliega una
# instancia EC2 con el módulo compute dentro de esa red.

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Red base para el ejemplo
module "vpc" {
  source = "../../vpc"

  project_name        = "ejemplo-compute"
  vpc_cidr_block      = "10.30.0.0/16"
  public_subnet_cidrs = ["10.30.1.0/24"]
}

# Security group mínimo: HTTP entrante y todo el egreso
resource "aws_security_group" "example" {
  name        = "ejemplo-compute-sg"
  description = "SG de ejemplo para el modulo compute"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP publico"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS saliente"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTP saliente"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Cómputo: una instancia EC2 en la subred pública
module "compute" {
  source = "../"

  project_name       = "ejemplo-compute"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [aws_security_group.example.id]
  os_type            = "linux"
  instance_count     = 1
  key_name           = "vockey"
}

output "instance_ids" {
  description = "IDs de las instancias creadas"
  value       = module.compute.instance_ids
}

output "instance_ips" {
  description = "IPs públicas de las instancias creadas"
  value       = module.compute.instance_ips
}
