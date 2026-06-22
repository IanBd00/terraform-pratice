# import {
#   to = oci_identity_compartment.compartment_import
#   id = "ocid1.compartment.oc1..aaaaaaaaqzvozf447lzep2c6fnpnqaz7vckblueqfg4rvuwcadr7lba6j56a"
# }

resource "oci_identity_compartment" "compartment_import" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaane6guqzdfn4a7mf2uozeebkcummsbicm4lzccrqmijsbhzvm6oga"
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/ian.bello@outlook.com"
    "Oracle-Tags.CreatedOn" = "2026-06-22T14:16:18.922Z"
  }
  description   = "Testando a função import do terraform para entendimentos."
  enable_delete = null
  freeform_tags = {}
  name          = "compartment-import-test"
}

# import {
#   to = oci_core_vcn.vcn_import
#   id = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaaybkvzgia342tq77s4epnkjt33l3gexqp3knmr5xic6foc5fyev4q"
# }

resource "oci_core_vcn" "vcn_import" {
  cidr_block     = "10.0.0.0/16"
  cidr_blocks    = ["10.0.0.0/16"]
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaqzvozf447lzep2c6fnpnqaz7vckblueqfg4rvuwcadr7lba6j56a"
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/ian.bello@outlook.com"
    "Oracle-Tags.CreatedOn" = "2026-06-22T14:17:16.211Z"
  }
  display_name            = "vcn_import"
  freeform_tags           = {}
  ipv6private_cidr_blocks = []
  is_ipv6enabled          = false
}

# import {
#   to = oci_core_internet_gateway.igw_import
#   id = "ocid1.internetgateway.oc1.sa-saopaulo-1.aaaaaaaapx7vjttghbdpynjbspnqm2hlk7xl2h5bfusm3d7ir2dsudlwckla"
# }

# import {
#   to = oci_core_route_table.rt_import
#   id = "ocid1.routetable.oc1.sa-saopaulo-1.aaaaaaaalsyww5syuvvoii72ci5vlrtwi53mldrlmmex5yldlqg74s3dnsta"
# }

# import {
#   to = oci_core_security_list.sl_import
#   id = "ocid1.securitylist.oc1.sa-saopaulo-1.aaaaaaaagkg6tdmievgv6ozh7tdjzwx7ftmrqvzb5jflwck6b3i3qkuybfxa"
# }

# import {
#   to = oci_core_subnet.subnet_import
#   id = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaafrspkyxwkuyswdcobxzhfnlnmof5zlejebd5cn7xezpu4lgdbgtq"
# }

resource "oci_core_subnet" "subnet_import" {
  cidr_block     = "10.0.1.0/24"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaqzvozf447lzep2c6fnpnqaz7vckblueqfg4rvuwcadr7lba6j56a"
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/ian.bello@outlook.com"
    "Oracle-Tags.CreatedOn" = "2026-06-22T14:18:13.008Z"
  }
  dhcp_options_id            = "ocid1.dhcpoptions.oc1.sa-saopaulo-1.aaaaaaaa4uhqtpkjuqornrbwcq3dgbeuobtiaxabusmjavhyuym34ray6nea"
  display_name               = "subnet-pub-import"
  freeform_tags              = {}
  ipv6cidr_blocks            = []
  prohibit_internet_ingress  = false
  prohibit_public_ip_on_vnic = false
  route_table_id             = "ocid1.routetable.oc1.sa-saopaulo-1.aaaaaaaalsyww5syuvvoii72ci5vlrtwi53mldrlmmex5yldlqg74s3dnsta"
  security_list_ids          = ["ocid1.securitylist.oc1.sa-saopaulo-1.aaaaaaaagkg6tdmievgv6ozh7tdjzwx7ftmrqvzb5jflwck6b3i3qkuybfxa"]
  vcn_id                     = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaaybkvzgia342tq77s4epnkjt33l3gexqp3knmr5xic6foc5fyev4q"
}

# __generated__ by Terraform from "ocid1.securitylist.oc1.sa-saopaulo-1.aaaaaaaagkg6tdmievgv6ozh7tdjzwx7ftmrqvzb5jflwck6b3i3qkuybfxa"
resource "oci_core_security_list" "sl_import" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaqzvozf447lzep2c6fnpnqaz7vckblueqfg4rvuwcadr7lba6j56a"
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/ian.bello@outlook.com"
    "Oracle-Tags.CreatedOn" = "2026-06-22T14:17:16.211Z"
  }
  display_name  = "Default Security List for vcn_import"
  freeform_tags = {}
  vcn_id        = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaaybkvzgia342tq77s4epnkjt33l3gexqp3knmr5xic6foc5fyev4q"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = false
  }
  ingress_security_rules {
    protocol    = "1"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = false
    icmp_options {
      code = -1
      type = 3
    }
  }
  ingress_security_rules {
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    icmp_options {
      code = 4
      type = 3
    }
  }
  ingress_security_rules {
    protocol    = "6"
    source      = "177.145.42.18/32"
    source_type = "CIDR_BLOCK"
    stateless   = false
    tcp_options {
      max = 22
      min = 22
    }
  }
}

# __generated__ by Terraform from "ocid1.routetable.oc1.sa-saopaulo-1.aaaaaaaalsyww5syuvvoii72ci5vlrtwi53mldrlmmex5yldlqg74s3dnsta"
resource "oci_core_route_table" "rt_import" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaqzvozf447lzep2c6fnpnqaz7vckblueqfg4rvuwcadr7lba6j56a"
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/ian.bello@outlook.com"
    "Oracle-Tags.CreatedOn" = "2026-06-22T14:17:16.211Z"
  }
  display_name  = "Default Route Table for vcn_import"
  freeform_tags = {}
  vcn_id        = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaaybkvzgia342tq77s4epnkjt33l3gexqp3knmr5xic6foc5fyev4q"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "ocid1.internetgateway.oc1.sa-saopaulo-1.aaaaaaaapx7vjttghbdpynjbspnqm2hlk7xl2h5bfusm3d7ir2dsudlwckla"
  }
}

# __generated__ by Terraform from "ocid1.internetgateway.oc1.sa-saopaulo-1.aaaaaaaapx7vjttghbdpynjbspnqm2hlk7xl2h5bfusm3d7ir2dsudlwckla"
resource "oci_core_internet_gateway" "igw_import" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaqzvozf447lzep2c6fnpnqaz7vckblueqfg4rvuwcadr7lba6j56a"
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/ian.bello@outlook.com"
    "Oracle-Tags.CreatedOn" = "2026-06-22T14:17:27.321Z"
  }
  display_name  = "igw-import"
  enabled       = true
  freeform_tags = {}
  vcn_id        = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaaybkvzgia342tq77s4epnkjt33l3gexqp3knmr5xic6foc5fyev4q"
}


# import {
#   to = oci_core_instance.instance_import 
#   id = "ocid1.instance.oc1.sa-saopaulo-1.antxeljrybkvzgicbc4j5no3jwnzgumjmigjcpbacev7qtsfbsvtu3i7ea4q"
# }

resource "oci_core_instance" "instance_import" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id             = "ocid1.compartment.oc1..aaaaaaaaqzvozf447lzep2c6fnpnqaz7vckblueqfg4rvuwcadr7lba6j56a"
  display_name      = "instance-import-test"
  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0Np2KlearPwOUdEFZ+24/iY861xpY9aHsfQ9pxPlu3xogKJXMozYySXHaC2csZE+tGzA4Dp0a3Yxnzs722SOXEIn6Vs3PB7VHjnF85mK74zFx8qZsBSg9BIbUiO0OO3wGjfzikPbEGKBQBQxEO+/bI4ENklKWIPaY2DSaEHPZw3cxCbbVkX+ZjKp7eQiqsKr5vPuuSBJoDnKdtHbJPh1eXu4wGYRNasUNGOQs2yIbmSV78fSfnKGoGbDBMCl5Ls4Qq4mYgv7LJ3xIbjnyoZhCL1Fv9J8ar3nHCZEPZb2NyS4K0dP39y8cbo1qmnoJOWRJyW22FTf4jajoclazAbZz ssh-key-2026-06-22"
  }
  shape                                   = "VM.Standard.E2.1.Micro"
  create_vnic_details {
    assign_public_ip       = "true"
    display_name           = "vnix-import"
    nsg_ids                = []
    private_ip             = "10.0.1.101"
    subnet_id              = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaafrspkyxwkuyswdcobxzhfnlnmof5zlejebd5cn7xezpu4lgdbgtq"
  }
  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = true
    is_pv_encryption_in_transit_enabled = true
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
  shape_config {
    memory_in_gbs = 1
    nvmes         = 0
    ocpus         = 1
    vcpus         = 2
  }
  source_details {
    boot_volume_size_in_gbs         = "47"
    boot_volume_vpus_per_gb         = "10"
    is_preserve_boot_volume_enabled = false
    kms_key_id                      = null
    source_id                       = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaavoyeb23qknp7omkdtwxvypwwe6nzoekcahgr7knwhpgq2wldaluq"
    source_type                     = "image"
  }
}
