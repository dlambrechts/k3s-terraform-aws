/* output "nodes_public_ip" {
  description = "Lista de IP públicas de los nodos"
  value       = ["${module.ec2_k3s_nodes.*}"]
}
 */
output "cp_public_ip" {
  description = "Dirección IP pública del Control Plane Cluster 1"
  value       = ["${module.ec2_k3s_main.public_ip}"]
}

/* output "instance_id" {
  description = "EC2 instance ID"
  value       = "${module.ec2_k3s_cp[0]}"
} */
