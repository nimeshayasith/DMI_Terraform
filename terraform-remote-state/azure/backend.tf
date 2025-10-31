terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "tfbackendny1761416956"  # Replace with your storage account
    container_name       = "tfstate"
    key                  = "azure-demo.tfstate"
    
    # Authentication via Azure CLI (default)
    # Or use ARM_ACCESS_KEY environment variable
  }
}

provider "azurerm" {
  features {}
}
