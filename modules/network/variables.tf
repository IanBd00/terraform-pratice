variable "compartment_id" {
    type = string
}

variable "vcn_name" {
    type = string
}

variable "vcn_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}
variable "private_subnet_cidr" {
  type = string
}

variable "ssh_source_ip" {
  type        = string
  description = "IP autorizado para SSH (formato CIDR, ex: 177.x.x.x/32)"
}

variable "internal_source_ip" {
  type        = string
  description = "IP interno autorizado para tráfego irrestrito (formato CIDR)"
}