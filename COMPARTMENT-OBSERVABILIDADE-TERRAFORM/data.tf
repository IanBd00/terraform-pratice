data "oci_identity_availability_domains" "ad" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "images" {
  compartment_id   = var.compartment_id
  operating_system = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape = "VM.Standard.A2.Flex"

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}