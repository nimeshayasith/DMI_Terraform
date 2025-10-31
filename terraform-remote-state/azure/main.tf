# Simple resource to test remote state
resource "azurerm_resource_group" "demo" {
  name     = "rg-remote-state-demo"
  location = "Central India"
  
  tags = {
    purpose    = "remote-state-testing"
    managed_by = "terraform"
    backend    = "azure-storage"
  }
}

# Add a storage account to test state updates
resource "azurerm_storage_account" "demo" {
  name                     = "stgdemo${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    purpose = "remote-state-testing"
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}
