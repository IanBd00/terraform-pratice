terraform {
  required_providers {
    oci = {
        source = "oracle/oci"
        version = "~> 5.0"
    }
  }

  backend "oci" {
    namespace = "grgxeup22eul"
    bucket = "tf-state-bucket"
    key = "COMPARTMENT-OBSERVABILIDADE-TERRAFORM/terraform.tfstate"
    region = "sa-saopaulo-1"
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  private_key_path = var.private_key_path
  region = var.region
  fingerprint = var.fingerprint
}