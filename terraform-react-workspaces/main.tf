terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}

  # Force use of Azure CLI authentication
  # use_cli = true
}

# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  keepers = {
    workspace = terraform.workspace
  }
}

# Deployment tracking ID
resource "random_string" "deployment_id" {
  length  = 8
  special = false
  upper   = false
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.current_config.location
  
  tags = merge(
    local.common_tags,
    {
      resource_type = "resource-group"
    }
  )
}

# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "asp-${local.current_config.resource_prefix}-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = local.current_config.sku_name
  
  tags = merge(
    local.common_tags,
    {
      resource_type = "app-service-plan"
      tier          = local.current_config.sku_name
    }
  )
}

# Linux Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = local.app_service_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id
  https_only          = local.current_config.enable_https_only
  
  site_config {
    always_on = local.current_config.always_on
    
    application_stack {
      node_version = var.node_version
    }
    
    # Enable detailed logging
    app_command_line = ""
    
    # CORS settings for React app
    cors {
      allowed_origins     = ["*"]
      support_credentials = false
    }
  }
  
  app_settings = {
    "ENVIRONMENT"              = terraform.workspace
    "NODE_ENV"                 = terraform.workspace == "prod" ? "production" : "development"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "false"
    "WORKSPACE"                = terraform.workspace
    "DEPLOYMENT_ID"            = random_string.deployment_id.result
  }
  
  logs {
    detailed_error_messages = true
    failed_request_tracing  = true
    
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }
  
  tags = merge(
    local.common_tags,
    {
      resource_type = "web-app"
      app_type      = "react"
      workspace     = terraform.workspace
    }
  )
}

# Storage Account for deployment artifacts (optional)
resource "azurerm_storage_account" "deployment" {
  name                     = "deploy${local.current_config.resource_prefix}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = merge(
    local.common_tags,
    {
      resource_type = "storage-account"
      purpose       = "deployment-artifacts"
    }
  )
}

# Storage Container for builds
resource "azurerm_storage_container" "builds" {
  name                  = "builds"
  storage_account_name  = azurerm_storage_account.deployment.name
  container_access_type = "private"
}