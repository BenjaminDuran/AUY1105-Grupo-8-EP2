# Ejemplo de uso — Módulo VPC

Ejemplo funcional mínimo que despliega la capa de red usando el módulo `vpc`: una VPC `10.20.0.0/16` con dos subredes públicas.

## Objetivo

Mostrar cómo invocar el módulo `vpc` y qué outputs entrega, para integrarlo en otros proyectos.

## Requisitos

- Terraform `>= 1.0.0` y proveedor AWS `>= 6.0`.
- Credenciales de AWS configuradas (variables de entorno del Learner Lab).
- Rol IAM `LabRole` existente (requerido por los VPC Flow Logs).

## Cómo ejecutar

```bash
cd modules/vpc/examples

terraform init
terraform plan
terraform apply -auto-approve
```

Al finalizar, `terraform output` muestra `vpc_id` y `public_subnet_ids`.

## Limpieza

```bash
terraform destroy -auto-approve
```

## Resultado esperado

| Output | Ejemplo |
|---|---|
| `vpc_id` | `vpc-0a1b2c3d4e5f...` |
| `public_subnet_ids` | `["subnet-0aaa...", "subnet-0bbb..."]` |
