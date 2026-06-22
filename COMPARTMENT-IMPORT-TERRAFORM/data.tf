data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "oracle_linux" {
  compartment_id = oci_identity_compartment.compartment_import.id
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}