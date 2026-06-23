resource "oci_identity_compartment" "compartment_oke" {
    compartment_id = var.tenancy_ocid
    name = "COMPARTMENT-OKE-TERRAFORM"
    description = "Compartment para OKE lab."
}

resource "oci_core_vcn" "vcn_oke" {
    compartment_id = var.compartment_ocid
    display_name = "VCN-OKE"
    cidr_block = "10.0.0.0/16"
}

resource "oci_core_internet_gateway" "igw_oke" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "IGW-OKE"
}

resource "oci_core_nat_gateway" "nat_oke" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "NATGW-OKE"
}

resource "oci_core_route_table" "rt_public" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "RT-PUBLIC-OKE"

    route_rules {
      destination = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      network_entity_id = oci_core_internet_gateway.igw_oke.id
    }
}

resource "oci_core_route_table" "rt_private" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "RT-PRIVATE-OKE"

    route_rules {
      destination = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      network_entity_id = oci_core_nat_gateway.nat_oke.id
    }
}

resource "oci_core_security_list" "sl_public" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "SL-PUBLIC"

    ingress_security_rules {
      source = "0.0.0.0/0"
      protocol = 6
      stateless = false

      tcp_options {
        min = 80
        max = 80
      }
    }

    ingress_security_rules {
      source = "0.0.0.0/0"
      protocol = 6
      stateless = false

      tcp_options {
        min = 443
        max = 443
      }
    }

    egress_security_rules {
      destination = "0.0.0.0/0"
      protocol = "all"
      stateless = false
    }
}

    resource "oci_core_security_list" "sl_private" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "SL-PRIVATE"

    ingress_security_rules {
      source = "10.0.0.0/16"
      protocol = "all"
      stateless = false
    }

    egress_security_rules {
      destination = "0.0.0.0/0"
      protocol = "all"
      stateless = false
    }
}

resource "oci_core_subnet" "subnet_lb" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "SUBNET-LB"

    cidr_block = "10.0.1.0/24"
    route_table_id = oci_core_route_table.rt_public.id
    security_list_ids = [ oci_core_security_list.sl_public.id ]
}

resource "oci_core_subnet" "subnet_workers" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "SUBNET-WORKERS"

    cidr_block = "10.0.2.0/24"
    route_table_id = oci_core_route_table.rt_private.id
    security_list_ids = [ oci_core_security_list.sl_private.id ]
}

resource "oci_core_subnet" "subnet_api" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.vcn_oke.id
    display_name = "SUBNET-API"

    cidr_block = "10.0.3.0/24"
    route_table_id = oci_core_route_table.rt_private.id
    security_list_ids = [ oci_core_security_list.sl_private.id ]
}

resource "oci_containerengine_cluster" "oke_cluster" {
  compartment_id     = var.compartment_ocid
  name               = "CLUSTER-OKE"
  kubernetes_version = "v1.36.0"
  vcn_id             = oci_core_vcn.vcn_oke.id

  endpoint_config {
    is_public_ip_enabled = false
    subnet_id            = oci_core_subnet.subnet_api.id
  }

  options {
    service_lb_subnet_ids = [oci_core_subnet.subnet_lb.id]

    add_ons {
      is_kubernetes_dashboard_enabled = false
      is_tiller_enabled               = false
    }
  }
}