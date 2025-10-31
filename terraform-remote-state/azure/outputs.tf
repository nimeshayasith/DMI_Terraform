output "resource_group_name" {
  description = "Name of the demo resource group"
  value       = azurerm_resource_group.demo.name
}

output "storage_account_name" {
  description = "Name of the demo storage account"
  value       = azurerm_storage_account.demo.name
}

output "backend_info" {
  description = "Backend configuration info"
  value = {
    backend_type = "azurerm"
    location     = "Azure Blob Storage"
    locking      = "Blob Lease (Native)"
  }
}
