variable "tenancy_ocid" {
    type = string
}

variable "user_ocid" {
    type = string
}

variable "region" {
    type = string
}

variable "private_key_path" {
    type = string
}

variable "fingerprint" {
    type = string
}

variable "name" {
    type = string
}

variable "description" {
    type = string
}

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

variable "ssh_public_key" {
  type = string
}

variable "public_subnet_id" {
    type = string
}

variable "private_subnet_id" {
    type = string
}