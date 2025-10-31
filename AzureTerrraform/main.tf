# Terraform configuration block
terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Azure provider configuration
# Authentication via environment variables (ARM_*)
provider "azurerm" {
  features {}
  # subscription_id, client_id, client_secret, tenant_id
  # are automatically read from ARM_* environment variables
}

# Create resource group to test authentication
resource "azurerm_resource_group" "rg" {
  name     = "rg-tf-sp-demo"
  location = "East US"
  
  tags = {
    environment = "demo"
    managed_by  = "terraform"
    purpose     = "service-principal-test"
  }
}

# Output resource group name
output "rg_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

# Output resource group location
output "rg_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.rg.location
}