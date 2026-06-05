# Ejemplo de uso — Módulo Compute

Ejemplo funcional completo que despliega una instancia EC2 con el módulo `compute`. Para ser autónomo, primero crea la red con el módulo `vpc` y un security group mínimo, y luego lanza la instancia dentro de esa red.

## Objetivo

Mostrar cómo invocar el módulo `compute` entregándole `subnet_id` y `security_group_ids`, y qué outputs produce.

## Requisitos

- Terraform `>= 1.0.0` y proveedor AWS `>= 6.0`.
- Credenciales de AWS configuradas (variables de entorno del Learner Lab).
- Key Pair `vockey` disponible en `us-east-1`.
- Rol `LabRole` y perfil de instancia `LabInstanceProfile` existentes en la cuenta.

## Cómo ejecutar

```bash
cd modules/compute/examples

terraform init
terraform plan
terraform apply -auto-approve
```

Al finalizar, `terraform output instance_ips` muestra la IP pública. El sitio Nginx queda accesible en `http://<IP_PUBLICA>`.

## Limpieza

```bash
terraform destroy -auto-approve
```

## Resultado esperado

| Output | Ejemplo |
|---|---|
| `instance_ids` | `["i-0a1b2c3d..."]` |
| `instance_ips` | `["54.0.1.2"]` |
