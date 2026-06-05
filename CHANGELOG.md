# Changelog

Todas las modificaciones importantes de este proyecto se documentarán en este archivo.

El formato sigue [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/)
y el versionado sigue [Semantic Versioning](https://semver.org/lang/es/).

Las versiones se ordenan de la más reciente a la más antigua.

---

## [Unreleased]

---

## [1.0.0] - 2026-06-05

### Added
- Versión estable y funcional de los módulos `vpc` y `compute`.

### Changed
- Trigger de deploy restaurado a `v*` para activar despliegue automático en versiones estables.

---

## [0.4.0] - 2026-06-05

### Added
- `modules/vpc/README.md` y `modules/compute/README.md` con objetivo, propósito, recursos, uso, variables, outputs y dependencias.
- Carpeta `modules/vpc/examples/` con ejemplo funcional (`main.tf`) y `README.md` de ejecución.
- Carpeta `modules/compute/examples/` con ejemplo autónomo (crea red, security group e instancia) y `README.md`.
- `.gitignore` actualizado para ignorar `.terraform.lock.hcl` en carpetas de ejemplos.

### Fixed
- Security group del ejemplo de cómputo con egress restringido (puertos 443/80) en vez de abierto, para cumplir `CKV_AWS_382`.

---

## [0.3.0] - 2026-06-05

### Changed
- Security group de servidores movido del `main.tf` raíz al módulo `vpc`, que ahora lo crea y expone el output `servers_security_group_id`.
- `main.tf` raíz consume el security group vía `module.vpc.servers_security_group_id`.

### Fixed
- Skip documentado de `CKV2_AWS_5` en Checkov (el SG se adjunta a la EC2 a través del módulo; Checkov no rastrea el adjunto entre módulos).

---

## [0.2.0] - 2026-06-05

### Added
- `modules/vpc/versions.tf` y `modules/compute/versions.tf` con restricciones de versión para Terraform (`>=1.0.0`) y provider AWS (`>=6.0`).

### Changed
- Variables de `modules/compute` movidas de `main.tf` a `variables.tf` con tipos y descripciones completas.

---

## [0.1.0] - 2026-06-05

### Added
- Estructura inicial del repositorio EP2 basada en el código de EP1.
- Módulos `vpc` y `compute` con archivos `main.tf`, `variables.tf` y `outputs.tf`.
- Pipeline CI con TFLint, Checkov, `terraform validate` y OPA.
- Workflows `deploy.yml` (despliegue automático con tag `v*`) y `destroy.yml` (destrucción manual).
- Backend S3 para estado remoto de Terraform.
- Sitio HTML estático desplegado vía `user_data` en EC2 con Nginx.

---

_Para ver el detalle de cada cambio consultar los Pull Requests en el repositorio._
