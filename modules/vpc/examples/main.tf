# Ejemplo funcional del módulo VPC.
# Crea una VPC con dos subredes públicas y expone sus identificadores.

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

module "vpc" {
  source = "../"

  project_name        = "ejemplo-vpc"
  vpc_cidr_block      = "10.20.0.0/16"
  public_subnet_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
}

output "vpc_id" {
  description = "ID de la VPC creada por el módulo"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas creadas por el módulo"
  value       = module.vpc.public_subnet_ids
}
