/* output "id" {
  description = "List of IDs of instances"
  value       = ["${module.ec2_k3s_cp.id}"]
} */

output "public_dns" {
  description = "Dirección IP pública del Control Plane"
  value       = ["${module.ec2_k3s-main.public_ip}"]
}

/* output "instance_id" {
  description = "EC2 instance ID"
  value       = "${module.ec2_k3s_cp[0]}"
} */