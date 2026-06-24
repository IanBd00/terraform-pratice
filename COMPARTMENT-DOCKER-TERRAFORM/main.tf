module "compartment" {
  source = "../modules/compartment"
  tenancy_ocid = var.tenancy_ocid
  name = var.compartment_name
  description = var.compartment_description
}

module "network" {
  source = "../modules/network(sl)"
  compartment_id = var.compartment_id
  vcn_name = var.vcn_name
  vcn_cidr = var.vcn_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr = var.public_subnet_cidr
}

module "compute" {
  source = "../modules/compute(sl)"
  compartment_id = module.compartment.compartment_id
  public_subnet_id = var.public_subnet_id
  shape = var.shape
  ssh_public_key = var.ssh_public_key
  instancename = var.instancename
  ocpu = var.ocpu
  ram = var.ram
}
