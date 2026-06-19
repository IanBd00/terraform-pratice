variable "compartment_id" {
    type = string
}

variable "public_subnet_id" {
    type = string
}


variable "nsg_id" {
    type = string
}

variable "shape" {
    type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "instances" {
  type        = map(string)
  description = "Mapa de instâncias a criar. Chave = nome local, valor = display_name."
}