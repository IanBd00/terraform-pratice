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