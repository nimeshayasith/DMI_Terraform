output "webapp_url" {
  description = "URL of the deployed React application"
  value       = "https://${azurerm_linux_web_app.webapp.default_hostname}"
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "environment" {
  description = "Current workspace/environment"
  value       = terraform.workspace
}

output "location" {
  description = "Deployment location"
  value       = local.current_config.location
}