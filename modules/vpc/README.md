# Módulo Terraform — VPC

Módulo reutilizable que crea la capa de red base en AWS: una VPC, subredes públicas en distintas zonas de disponibilidad, Internet Gateway, tabla de rutas y VPC Flow Logs cifrados con KMS.

## Objetivo

Desacoplar la creación de la red para poder reutilizarla en cualquier proyecto sin duplicar código, garantizando una configuración consistente y segura (Flow Logs + KMS, security group por defecto bloqueado).

## Propósito

Provee los identificadores de red (`vpc_id`, `public_subnet_ids`) que consumen otros módulos —como el de cómputo— para desplegar recursos dentro de la VPC.

## Recursos creados

- `aws_vpc` con DNS habilitado.
- `aws_default_security_group` bloqueado (sin reglas).
- `aws_internet_gateway` y `aws_route_table` pública con ruta `0.0.0.0/0`.
- `aws_subnet` públicas (una por CIDR entregado) con IP pública automática.
- `aws_flow_log` + `aws_cloudwatch_log_group` + `aws_kms_key` para auditoría de tráfico.

## Uso

```hcl
module "vpc" {
  source = "./modules/vpc"

  project_name        = "grupo8"
  vpc_cidr_block      = "10.1.0.0/16"
  public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
}
```

Ver un ejemplo funcional completo en [`examples/`](./examples/).

## Variables de entrada

| Variable | Descripción | Tipo | Requerida |
|---|---|---|---|
| `project_name` | Nombre del proyecto, usado para etiquetar los recursos. | `string` | Sí |
| `vpc_cidr_block` | Rango de IPs (CIDR) para la VPC. | `string` | Sí |
| `public_subnet_cidrs` | Lista de CIDRs para las subredes públicas (una subred por elemento). | `list(string)` | Sí |

## Outputs

| Output | Descripción |
|---|---|
| `vpc_id` | ID de la VPC creada. |
| `public_subnet_ids` | Lista de IDs de las subredes públicas creadas. |

## Dependencias

- Terraform `>= 1.0.0`
- Proveedor `hashicorp/aws` `>= 6.0`
- Rol IAM `LabRole` existente en la cuenta (usado por los Flow Logs).
