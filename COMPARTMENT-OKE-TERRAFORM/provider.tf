terraform {
    required_providers {
      oci = {
      source = "oracle/oci"
      version = "~> 5.0"
      }
    }

    backend "oci" {
        bucket = "tf-state-bucket"
        namespace = "grgxeup22eul"
        key = "COMPARTMENT-OKE-TERRAFORM/terraform.tfstate"
        region = "sa-saopaulo-1"
    }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  region = var.region
  private_key_path = var.private_key_path
}