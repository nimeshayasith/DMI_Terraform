# azure/east-us/main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-multicloud-assets-eastus"
  location = "East US"
  
  tags = {
    project     = "multicloud-foundation"
    owner       = "nimesha-yasith"
    environment = "dev"
    cloud       = "azure"
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "stgdeveus${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    project     = "multicloud-foundation"
    owner       = "nimesha-yasith"
    environment = "dev"
    region      = "eastus"
    cloud       = "azure"
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}