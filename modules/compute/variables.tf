variable "project_name" {
  description = "Nombre del proyecto, usado para etiquetar los recursos"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subred donde se alojará la instancia"
  type        = string
}

variable "security_group_ids" {
  description = "Lista de IDs de Security Groups a asociar a la instancia"
  type        = list(string)
}

variable "os_type" {
  description = "Sistema Operativo de la instancia (ej: 'linux')"
  type        = string
}

variable "instance_count" {
  description = "Cantidad de instancias a crear"
  type        = number
}

variable "key_name" {
  description = "Nombre del Key Pair de AWS para acceso SSH"
  type        = string
}
