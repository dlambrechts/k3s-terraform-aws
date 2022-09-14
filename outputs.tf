/* output "nodes_public_ip" {
  description = "Lista de IP públicas de los nodos"
  value       = ["${module.ec2_k3s_nodes.*}"]
}
 */
output "cp_public_ip" {
  description = "Dirección IP pública del Control Plane Cluster 1"
  value       = ["${module.ec2_k3s_main.public_ip}"]
}

output "workers_ip" {
  value = values(module.ec2_k3s_workers)[*].public_ip
}

