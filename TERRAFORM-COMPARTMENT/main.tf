module "compartment" {
  source = "./modules/compartment"
  tenancy_ocid = var.tenancy_ocid
  name = var.compartment_name
  description = var.compartment_description
}

module "network" {
  source = "./modules/network"
  compartment_id = module.compartment.compartment_id
  vcn_cidr = var.vcn_cidr
  vcn_name = var.vcn_display_name
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  ssh_source_ip = var.ssh_source_ip
  internal_source_ip = var.internal_source_ip
}

module "compute" {
  source = "./modules/compute"
  compartment_id = module.compartment.compartment_id
  public_subnet_id = module.network.public_subnet_id
  nsg_id = module.network.nsg_id
  shape = var.shape
  ssh_public_key_path = var.ssh_public_key_path
  instancename = var.instancename
}
