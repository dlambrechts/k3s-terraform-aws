/* output "id" {
  description = "List of IDs of instances"
  value       = ["${module.ec2_k3s_cp.id}"]
} */

output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = ["${module.ec2_k3s-main.public_dns}"]
}

/* output "instance_id" {
  description = "EC2 instance ID"
  value       = "${module.ec2_k3s_cp[0]}"
} */