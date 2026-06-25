module "compartment" {
    source = "../modules/compartment"
    tenancy_ocid = var.tenancy_ocid
    name = var.name
    description = var.description
}

module "network" {
    source = "../modules/network(sl)"

    compartment_id = var.compartment_id
    vcn_name = var.vcn_name
    vcn_cidr = var.vcn_cidr
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
}

resource "oci_core_instance" "vm_monitoring" {
  display_name        = "VM-MONITORING"
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
  shape               = "VM.Standard.A2.Flex"

  source_details {
    source_id   = data.oci_core_images.images.images[0].id
    source_type = "image"
  }

  shape_config {
    ocpus = 2
    memory_in_gbs = 12
  }

  create_vnic_details {
    subnet_id        = var.public_subnet_id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}


resource "oci_core_instance" "vm_agent" {
  display_name        = "VM-AGENT"
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
  shape               = "VM.Standard.A2.Flex"

  source_details {
    source_id   = data.oci_core_images.images.images[0].id
    source_type = "image"
  }

  shape_config {
    ocpus = 1
    memory_in_gbs = 6
  }

  create_vnic_details {
    subnet_id        = var.private_subnet_id
    assign_public_ip = false
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}