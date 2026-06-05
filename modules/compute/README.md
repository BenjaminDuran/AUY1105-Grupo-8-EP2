# Módulo Terraform — Compute (EC2)

Módulo reutilizable que despliega una o más instancias EC2 Ubuntu 24.04 LTS (`t2.micro`) con Nginx preinstalado vía `user_data`, endurecidas con IMDSv2, disco raíz cifrado y monitoreo detallado.

## Objetivo

Desacoplar la creación de los recursos de cómputo para reutilizarlos en cualquier proyecto, parametrizando red, seguridad y cantidad de instancias.

## Propósito

Lanzar instancias EC2 dentro de una subred y un security group entregados por el llamador (normalmente desde el módulo `vpc`), exponiendo sus IDs e IPs públicas para su consumo posterior.

## Recursos creados

- `aws_instance` (cantidad parametrizable vía `instance_count`) con:
  - AMI más reciente de Ubuntu 24.04 LTS (Canonical).
  - IMDSv2 obligatorio (`http_tokens = required`).
  - Disco raíz cifrado y `monitoring` habilitado.
  - `user_data` que instala y habilita Nginx sirviendo un sitio estático.
- `data "aws_ami"` para resolver la AMI de Ubuntu.

## Uso

```hcl
module "compute" {
  source = "./modules/compute"

  project_name       = "grupo8"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.servers_security_group_id]
  os_type            = "linux"
  instance_count     = 1
  key_name           = "vockey"
}
```

Ver un ejemplo funcional completo (red + security group + cómputo) en [`examples/`](./examples/).

## Variables de entrada

| Variable | Descripción | Tipo | Requerida |
|---|---|---|---|
| `project_name` | Nombre del proyecto, usado para etiquetar los recursos. | `string` | Sí |
| `subnet_id` | ID de la subred donde se alojará la instancia. | `string` | Sí |
| `security_group_ids` | Lista de IDs de Security Groups a asociar a la instancia. | `list(string)` | Sí |
| `os_type` | Sistema operativo de la instancia (ej. `linux`). Usado como tag. | `string` | Sí |
| `instance_count` | Cantidad de instancias a crear. | `number` | Sí |
| `key_name` | Nombre del Key Pair de AWS para acceso SSH. | `string` | Sí |

## Outputs

| Output | Descripción |
|---|---|
| `instance_ids` | Lista de IDs de las instancias creadas. |
| `instance_ips` | Lista de IPs públicas de las instancias creadas. |

## Dependencias

- Terraform `>= 1.0.0`
- Proveedor `hashicorp/aws` `>= 6.0`
- Perfil de instancia IAM `LabInstanceProfile` existente en la cuenta.
- Una subred y un security group previamente creados (ver módulo `vpc`).
