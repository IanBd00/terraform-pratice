locals {
  env_config = {
    dev = {
        # VCN
      vcn_display_name = "VCN-WORKSPACE-DEV"
      vcn_cidr_block = "10.0.0.0/16"

      igw_display_name = "IGW-DEV"

      rt_public_display_name = "RT-PUBLIC-DEV"

      sl_display_name = "SECURITY-LIST-DEV"

      subnet_display_name = "SUBNET-PUBLIC-DEV"
      subnet_cidr_block = "10.0.1.0/24"

      instance_display_name = "INSTANCE-DEV"
      shape = "VM.Standard.E2.1.Micro"
    }
    prod = {
        # VCN
      vcn_display_name = "VCN-WORKSPACE-PROD"
      vcn_cidr_block = "172.16.0.0/16"

      igw_display_name = "IGW-PROD"

      rt_public_display_name = "RT-PUBLIC-PROD"

      sl_display_name = "SECURITY-LIST-PROD"

      subnet_display_name = "SUBNET-PUBLIC-PROD"
      subnet_cidr_block = "172.16.1.0/24"

      instance_display_name = "INSTANCE-PROD"
      shape = "VM.Standard.E2.1.Micro"
    }
  }

  env = local.env_config[terraform.workspace]
}

resource "oci_core_vcn" "vcn-workspace" {
    compartment_id = var.compartment_id
    display_name = local.env.vcn_display_name
    cidr_block = local.env.vcn_cidr_block
}

resource "oci_core_internet_gateway" "igw-workspace" {
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.vcn-workspace.id
  display_name = local.env.igw_display_name
}

resource "oci_core_route_table" "rt-workspace" {
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.vcn-workspace.id
  display_name = local.env.rt_public_display_name

  route_rules {
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw-workspace.id
  }
}

  resource "oci_core_security_list" "sl-workspace" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn-workspace.id
    display_name = local.env.sl_display_name

    ingress_security_rules {
      source = "177.145.42.18/32"
      protocol = 6

      tcp_options {
        min = 22
        max = 22
      }
    }

    egress_security_rules {
      destination = "0.0.0.0/0"
      protocol = "all"
    }
  }

  resource "oci_core_subnet" "subnet-pub-workspace" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn-workspace.id
    display_name = local.env.subnet_display_name

    cidr_block = local.env.subnet_cidr_block
    route_table_id = oci_core_route_table.rt-workspace.id
    security_list_ids = [ oci_core_security_list.sl-workspace.id ]
  }

  resource "oci_core_instance" "instance-workspace" {
    display_name = local.env.instance_display_name
    compartment_id = var.compartment_id
    availability_domain = data.oci_identity_availability_domains.ad.availability_domains[0].name
    shape = local.env.shape

    create_vnic_details {
      subnet_id = oci_core_subnet.subnet-pub-workspace.id
      assign_public_ip = true
    }

    source_details {
      source_type = "image"
      source_id = data.oci_core_images.oracle_linux.images[0].id
    }

    metadata = {
      ssh_authorized_keys = var.ssh_pub_key[terraform.workspace]
    }
  }