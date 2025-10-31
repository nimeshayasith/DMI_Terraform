output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.vnet.name
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = azurerm_subnet.public.id
}

output "mysql_subnet_id" {
  description = "MySQL subnet ID"
  value       = azurerm_subnet.mysql.id
}

output "delegated_subnet_id" {
  description = "Delegated subnet ID for database"
  value       = azurerm_subnet.mysql.id
}

output "public_nsg_id" {
  description = "Public NSG ID"
  value       = azurerm_network_security_group.public_nsg.id
}

output "mysql_nsg_id" {
  description = "MySQL NSG ID"
  value       = azurerm_network_security_group.mysql_nsg.id
}