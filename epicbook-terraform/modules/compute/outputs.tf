output "vm_id" {
  description = "VM ID"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "VM name"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "public_ip" {
  description = "VM public IP"
  value       = azurerm_public_ip.vm.ip_address
}

output "private_ip" {
  description = "VM private IP"
  value       = azurerm_network_interface.vm.private_ip_address
}