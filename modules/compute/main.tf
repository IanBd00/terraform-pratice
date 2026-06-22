data "oci_identity_availability_domains" "ad" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "images" {
  compartment_id           = var.compartment_id
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "this" {
  display_name        = var.instancename
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
  shape               = var.shape

  source_details {
    source_id   = data.oci_core_images.images.images[0].id
    source_type = "image"
  }

  create_vnic_details {
    subnet_id        = var.public_subnet_id
    assign_public_ip = true
    nsg_ids          = [var.nsg_id]
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
}