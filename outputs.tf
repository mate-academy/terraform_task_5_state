output "public_ip_address" {
  description = "Public IP address of the existing VM"
  value       = local.public_ip_address
}

output "vm_name" {
  description = "Name of the existing VM"
  value       = data.azurerm_virtual_machine.main.name
}

output "vm_status" {
  description = "Power status of the existing VM"
  value       = data.azurerm_virtual_machine.main.power_state
}

output "ssh_connection" {
  description = "SSH connection string"
  value       = "ssh ${var.admin_username}@${local.public_ip_address}"
  sensitive   = true
}

output "nginx_url" {
  description = "URL to access Nginx"
  value       = "http://${local.public_ip_address}"
}