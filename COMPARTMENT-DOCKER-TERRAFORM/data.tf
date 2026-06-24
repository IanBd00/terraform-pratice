data "oci_identity_availability_domains" "ad" {
    compartment_id = var.tenancy_ocid
}

# data "oci_core_images" "oracle_linux" {
#     compartment_id = var.compartment_id
#     operating_system = "Oracle Linux"
#     operating_system_version = "9"

#     shape = "VM.Standard.E2.1.Micro"
#     sort_by = "TIMECREATED"
#     sort_order = "DESC"
# }