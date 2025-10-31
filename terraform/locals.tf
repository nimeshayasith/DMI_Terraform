locals {
  # Environment-specific settings
  env_config = {
    dev = {
      location       = "Canada Central"
      sku_name      = "F1"
      app_name      = "reactapp-dev"
      resource_prefix = "dev"
    }
    prod = {
      location       = "Southeast Asia"
      sku_name      = "B1"
      app_name      = "reactapp-prod"
      resource_prefix = "prod"
    }
  }
  
  # Current workspace configuration
  current_config = local.env_config[terraform.workspace]
  
  # Common tags
  common_tags = {
    project     = "react-app-deployment"
    owner       = "nimesha-yasith"
    environment = terraform.workspace
    managed_by  = "terraform"
  }
}