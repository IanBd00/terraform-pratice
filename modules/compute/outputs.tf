output "instance_ids" {
  value = { for k, v in oci_core_instance.this : k => v.id }
}

output "instance_display_names" {
  value = { for k, v in oci_core_instance.this : k => v.display_name }
}