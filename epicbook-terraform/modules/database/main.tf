# Private DNS Zone for MySQL
resource "azurerm_private_dns_zone" "mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link Private DNS Zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "mysql" {
  name                  = "${var.server_name}-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

# MySQL Flexible Server with B_Standard_B1ms (minimum supported SKU)
resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  
  # CRITICAL: Use B_Standard_B1ms (not B1s)
  sku_name               = "B_Standard_B1ms"
  version                = "8.0.21"
  
  delegated_subnet_id    = var.mysql_subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.mysql.id
  
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  
  storage {
    size_gb = 20
    iops    = 360
  }
  
  tags = var.tags
  
  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.mysql
  ]
}

# Create Database
resource "azurerm_mysql_flexible_database" "db" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}

