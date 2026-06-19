resource "oci_core_vcn" "this" {
    display_name = var.vcn_name
    compartment_id = var.compartment_id
    cidr_block = var.vcn_cidr
}

resource "oci_core_internet_gateway" "this" {
    display_name = "IGW-${var.vcn_name}"
    compartment_id =  var.compartment_id
    vcn_id = oci_core_vcn.this.id
}

resource "oci_core_nat_gateway" "this" {
    display_name = "NAT-${var.vcn_name}"
    compartment_id =  var.compartment_id
    vcn_id = oci_core_vcn.this.id
}

resource "oci_core_route_table" "public" {
    display_name = "PUBLIC-RT-${var.vcn_name}"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id

    route_rules {
        network_entity_id = oci_core_internet_gateway.this.id
        destination = "0.0.0.0/0"
      
    }
}

resource "oci_core_route_table" "private"{
    display_name = "RT-PRIVATE-${var.vcn_name}"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id

    route_rules {
        network_entity_id = oci_core_nat_gateway.this.id
        destination = "0.0.0.0/0"
    }
}


locals {
    ports = {
        http = 80
        https =  443
    }
}


resource "oci_core_network_security_group" "this" {
    display_name = "NSG-${var.vcn_name}"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id
}

resource "oci_core_network_security_group_security_rule" "ingress_tcp" {
  for_each = local.ports

  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = "INGRESS"
  protocol                  = "6"

  source      = "0.0.0.0/0"
  source_type = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = each.value
      max = each.value
    }
  }
}

resource "oci_core_network_security_group_security_rule" "ingress_ssh" {
  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = "INGRESS"
  protocol                  = "6"

  source      = var.ssh_source_ip
  source_type = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "ingress_all" {
  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = "INGRESS"
  protocol                  = "all"

  source      = var.internal_source_ip
  source_type = "CIDR_BLOCK"
}

resource "oci_core_subnet" "public" {
    display_name = "PUBLIC-SUBNET-${var.vcn_name}"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id
    cidr_block = var.public_subnet_cidr
    route_table_id = oci_core_route_table.public.id
}

resource "oci_core_subnet" "private" {
    display_name = "PRIVATE-SUBNET-${var.vcn_name}"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id
    cidr_block = var.private_subnet_cidr
    route_table_id = oci_core_route_table.private.id
    prohibit_public_ip_on_vnic = true
}