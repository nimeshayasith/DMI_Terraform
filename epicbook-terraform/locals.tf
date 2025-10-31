locals {
  # Environment-specific configuration
  # Using regions commonly available in Azure Student accounts
  env_config = {
    default = {
      location         = "Canada Central"  # Common free region
      vm_size          = "Standard_B1s"
      db_sku           = "B_Standard_B1s"
      environment_tag  = "default"
      name_prefix      = "default"
    }
    dev = {
      location         = "Canada Central"          # Free tier friendly
      vm_size          = "Standard_B1s"     # Available in student
      db_sku           = "B_Standard_B1s"   # Basic tier
      environment_tag  = "development"
      name_prefix      = "dev"
    }
    prod = {
      location         = "West Europe"      # Alternative free region
      vm_size          = "Standard_B1s"     # Keep same size for student
      db_sku           = "B_Standard_B1s"   # Keep basic for student
      environment_tag  = "production"
      name_prefix      = "prod"
    }
  }
  
  # Current workspace configuration
  current_env = local.env_config[terraform.workspace]
  
  # Common naming
  project_name = "epicbook"
  owner        = "nimesha-yasith"
  
  # Common tags
  common_tags = {
    project     = local.project_name
    owner       = local.owner
    environment = terraform.workspace
    managed_by  = "terraform"
    created_at  = timestamp()
  }
  
  # Resource naming
  resource_prefix = "${terraform.workspace}-${local.project_name}"
}