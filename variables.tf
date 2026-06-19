variable "tenancy_ocid" {
  description = "The OCID of the tenancy."
  type        = string
}

variable "user_ocid" {
  description = "The OCID of the user."
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint of the API key."
  type        = string
}

variable "private_key_path" {
  description = "The path to the private key file."
  type        = string
  default = null
}

variable "private_key" {
  type = string
  default = null
  sensitive = true
}


variable "region" {
  description = "The region to use for API calls."
  type        = string
}


variable "compartment_name" {
  type = string
}

variable "compartment_description" {
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

variable "vcn_display_name" {
  type = string
}

variable "ssh_source_ip" {
  type = string
}

variable "internal_source_ip" {
  type = string
}

variable "shape" {
  type    = string
  default = "VM.Standard.E2.1.Micro"
}

variable "ssh_public_key_path" {
  type = string
}

variable "instances" {
  type = map(string)
}