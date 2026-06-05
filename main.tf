# Archivo principal de Terraform. Aquí se definen los recursos principales
# y se llaman a los módulos para crear la infraestructura completa.

# ---------------------------------------------------------
# VPC
# ---------------------------------------------------------
# Llama a nuestro módulo local que está en la carpeta modules/vpc
module "vpc" {
  source = "./modules/vpc"

  # Aquí le pasamos las variables que el módulo necesita
  project_name        = var.project_name
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
}

# ---------------------------------------------------------
# APP 1: LINUX (1 Instancia)
# ---------------------------------------------------------
module "app1_linux_compute" {
  source       = "./modules/compute"
  project_name = var.project_name
  # Ponemos la instancia en la primera subred pública
  subnet_id = module.vpc.public_subnet_ids[0]
  # Security Group de servidores provisto por el módulo de redes
  security_group_ids = [module.vpc.servers_security_group_id]
  os_type            = "linux"
  instance_count     = var.instance_count_app1
  key_name           = var.key_name
}
