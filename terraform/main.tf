terraform {
  required_version = ">= 1.5.0"
  
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

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.current_config.resource_prefix}-reactapp"
  location = local.current_config.location
  tags     = local.common_tags
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "asp-${local.current_config.resource_prefix}-reactapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = local.current_config.sku_name
  tags                = local.common_tags
}

# App Service (Static Web App alternative)
resource "azurerm_linux_web_app" "webapp" {
  name                = "${local.current_config.app_name}-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id
  
  site_config {
    always_on = terraform.workspace == "prod" ? true : false
    
    application_stack {
      node_version = "18-lts"
    }
  }
  
  app_settings = {
    "ENVIRONMENT" = terraform.workspace
    "NODE_ENV"    = terraform.workspace == "prod" ? "production" : "development"
  }
  
  tags = local.common_tags
}

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}