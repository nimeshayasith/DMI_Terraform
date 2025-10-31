# azure/west-europe/main.tf
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
  name     = "rg-multicloud-assets-westeurope"
  location = "West Europe"
  
  tags = {
    project     = "multicloud-foundation"
    owner       = "nimesha-yasith"
    environment = "dev"
    cloud       = "azure"
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "stgdeveu${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    project     = "multicloud-foundation"
    owner       = "nimesha-yasith"
    environment = "dev"
    region      = "westeurope"
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