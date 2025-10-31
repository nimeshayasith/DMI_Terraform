locals {
  # Environment-specific configuration map
  env_config = {
    dev = {
      location            = "East US"
      sku_name           = "F1"              # Free tier for dev
      app_name           = "reactapp-dev"
      resource_prefix    = "dev"
      always_on          = false             # Not available in F1
      environment_tag    = "development"
      enable_https_only  = false
    }
    prod = {
      location            = "West US"
      sku_name           = "B1"              # Basic tier for prod
      app_name           = "reactapp-prod"
      resource_prefix    = "prod"
      always_on          = true              # Keep app warm
      environment_tag    = "production"
      enable_https_only  = true
    }
  }
  
  # Select configuration based on current workspace
  current_config = local.env_config[terraform.workspace]
  
  # Common tags applied to all resources
  common_tags = {
    project        = "react-app-deployment"
    owner          = "nimesha-yasith"
    environment    = terraform.workspace
    managed_by     = "terraform"
    deployment_id  = random_string.deployment_id.result
    created_date   = timestamp()
  }
  
  # Derived values
  resource_group_name = "rg-${local.current_config.resource_prefix}-reactapp-${random_string.suffix.result}"
  app_service_name    = "${local.current_config.app_name}-${random_string.suffix.result}"
}