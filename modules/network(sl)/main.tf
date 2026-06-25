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
    display_name = "PRIVATE-RT-${var.vcn_name}"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id

    route_rules {
        network_entity_id = oci_core_nat_gateway.this.id
        destination = "0.0.0.0/0"
    }
}

resource "oci_core_security_list" "this" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id
    display_name = "NSG-${var.vcn_name}"

    ingress_security_rules {
      source = "0.0.0.0/0"
      protocol = "6"

      tcp_options {
        min = "22"
        max = "22"
      }
    }

    ingress_security_rules {
      source = "0.0.0.0/0"
      protocol = "6"

      tcp_options {
        min = "80"
        max = "80"
      }
    }

    ingress_security_rules {
      source = "0.0.0.0/0"
      protocol = "6"

      tcp_options {
        min = "443"
        max = "443"
      }
    }

    ingress_security_rules {
      source = "0.0.0.0/0"
      protocol = "6"

      tcp_options {
        min = "8080"
        max = "8080"
      }
    }

    ingress_security_rules {
      source = "0.0.0.0/0"
      protocol = "6"

      tcp_options {
        min = "3000"
        max = "3000"
      }
    }

    ingress_security_rules {
      source = "0.0.0.0/0"
      protocol = "6"

      tcp_options {
        min = "10051"
        max = "10051"
      }
    }

    egress_security_rules {
      destination = "0.0.0.0/0"
      protocol = "all"
    }
}


resource "oci_core_subnet" "public" {
    display_name = "PUBLIC-SUBNET-${var.vcn_name}"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id
    cidr_block = var.public_subnet_cidr
    route_table_id = oci_core_route_table.public.id
    security_list_ids = [ oci_core_security_list.this.id ]
}

resource "oci_core_subnet" "private" {
    display_name = "PRIVATE-SUBNET-${var.vcn_name}"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.this.id
    cidr_block = var.private_subnet_cidr
    route_table_id = oci_core_route_table.private.id
    prohibit_public_ip_on_vnic = true
    security_list_ids = [ oci_core_security_list.this.id ]
}