output "compartment_id" {
  value = module.compartment.compartment_id
}

output "vcn_id" {
  value = module.network.vcn_id
}

output "instance_ids" {
  value = module.compute.instance_ids
}