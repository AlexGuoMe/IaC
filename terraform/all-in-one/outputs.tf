output "security_group_ids" {
  value       = module.ssh_security_group.security_group_id
}

output "subnet_id" {
  value       = "${random_shuffle.az.result}"
}

output "ins_id" {
  value       = element(module.ec2_instance, 1).id
  # value       = element(module.ec2_instance.*.id, count.index)
}
