# Outputs
output "server_fqdn" {
  description = "MySQL server FQDN"
  value       = azurerm_mysql_flexible_server.mysql.fqdn
}

output "server_name" {
  description = "MySQL server name"
  value       = azurerm_mysql_flexible_server.mysql.name
}

output "database_name" {
  description = "Database name"
  value       = azurerm_mysql_flexible_database.db.name
}

output "admin_username" {
  description = "Admin username"
  value       = azurerm_mysql_flexible_server.mysql.administrator_login
  sensitive   = true
}