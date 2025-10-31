variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "server_name" {
  description = "MySQL server name"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

# variable "sku_name" {
#   description = "Database SKU"
#   type        = string
#   default     = "B_Gen5_1"
# }

variable "mysql_subnet_id" {
  description = "MySQL subnet ID"
  type        = string
}

variable "vnet_id" {
  description = "Virtual network ID"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}