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

        tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaane6guqzdfn4a7mf2uozeebkcummsbicm4lzccrqmijsbhzvm6oga"
        user_ocid = "ocid1.user.oc1..aaaaaaaaskoxhq6j6iqmfkzhaq4alhwpwflssrwdxgqg2uwmomyyvxfir37a"
        fingerprint = "ba:2f:cc:10:e2:71:28:6b:92:a0:2f:3f:f4:c1:21:fd"
        private_key_path = "C:/Users/ian.bello/Documents/KEYS/API_KEY/oci_api_key.pem"
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