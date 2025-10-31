output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}

output "vm_public_ip" {
  description = "VM public IP address"
  value       = module.compute.public_ip
}

output "vm_private_ip" {
  description = "VM private IP address"
  value       = module.compute.private_ip
}

output "database_fqdn" {
  description = "Database server FQDN"
  value       = module.database.server_fqdn
}

output "site_url" {
  description = "EpicBook application URL"
  value       = "http://${module.compute.public_ip}"
}

output "environment" {
  description = "Current workspace/environment"
  value       = terraform.workspace
}

output "location" {
  description = "Deployment location"
  value       = local.current_env.location
}

output "vnet_name" {
  description = "Virtual network name"
  value       = module.network.vnet_name
}

output "vnet_id" {
  description = "Virtual network ID"
  value       = module.network.vnet_id
}