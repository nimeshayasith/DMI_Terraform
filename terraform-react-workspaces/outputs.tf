output "workspace" {
  description = "Current Terraform workspace"
  value       = terraform.workspace
}

output "webapp_url" {
  description = "URL of the deployed React application"
  value       = "https://${azurerm_linux_web_app.webapp.default_hostname}"
}

output "webapp_name" {
  description = "Name of the web app"
  value       = azurerm_linux_web_app.webapp.name
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "Deployment location"
  value       = local.current_config.location
}

output "environment" {
  description = "Current environment configuration"
  value = {
    name          = terraform.workspace
    location      = local.current_config.location
    sku           = local.current_config.sku_name
    always_on     = local.current_config.always_on
    https_only    = local.current_config.enable_https_only
  }
}

output "deployment_info" {
  description = "Deployment information"
  value = {
    deployment_id   = random_string.deployment_id.result
    timestamp       = timestamp()
    resource_prefix = local.current_config.resource_prefix
  }
}

output "storage_account_name" {
  description = "Storage account for deployment artifacts"
  value       = azurerm_storage_account.deployment.name
}

output "deployment_command" {
  description = "Command to deploy the React app"
  value = <<-EOT
    cd ../my-react-app
    zip -r build.zip build/*
    az webapp deployment source config-zip \
      --resource-group ${azurerm_resource_group.rg.name} \
      --name ${azurerm_linux_web_app.webapp.name} \
      --src build.zip
  EOT
}