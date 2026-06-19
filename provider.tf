terraform{
    required_providers{
        oci = {
            source = "oracle/oci"
            version = "~> 5.0"
        }
    }

    backend "oci" {
        bucket = "tf-state-bucket"
        key = "gnexum/terraform.tfstate"
        namespace = "grgxeup22eul"
        region = "sa-saopaulo-1"
    }
}

provider "oci" {
    tenancy_ocid     = var.tenancy_ocid
    user_ocid        = var.user_ocid
    fingerprint      = var.fingerprint
    private_key_path = var.private_key_path
    private_key      = var.private_key
    region           = var.region
}