# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${local.resource_prefix}-rg"
  location = local.current_env.location
  tags     = local.common_tags
}

# Random suffix for unique MySQL server name
resource "random_string" "mysql_suffix" {
  length  = 6
  special = false
  upper   = false
}

# Network Module
module "network" {
  source = "./modules/network"
  
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = "${local.resource_prefix}-vnet"
  vnet_address_space  = ["10.0.0.0/16"]
  allowed_ssh_ip      = var.allowed_ssh_ip
  tags                = local.common_tags
}

# Database Module
module "database" {
  source = "./modules/database"
  
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  server_name         = "${local.resource_prefix}-mysql-${random_string.mysql_suffix.result}"
  db_name             = var.db_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  # sku_name            = local.current_env.db_sku
  mysql_subnet_id     = module.network.delegated_subnet_id
  vnet_id             = module.network.vnet_id
  tags                = local.common_tags
  
  depends_on = [module.network]
}

# Compute Module
module "compute" {
  source = "./modules/compute"
  
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_name             = "${local.resource_prefix}-vm"
  vm_size             = local.current_env.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  subnet_id           = module.network.public_subnet_id
  db_host             = module.database.server_fqdn
  db_name             = module.database.database_name
  db_username         = module.database.admin_username
  db_password         = var.admin_password
  github_repo_url     = var.github_repo_url
  tags                = local.common_tags
  
  depends_on = [module.database]
}