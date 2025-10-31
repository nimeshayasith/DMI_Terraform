variable "admin_username" {
  description = "Admin username for VM and database"
  type        = string
  default     = "epicbookadmin"
}

variable "admin_password" {
  description = "Admin password for VM and database"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "epicbook"
}

variable "allowed_ssh_ip" {
  description = "Your IP address for SSH access"
  type        = string
}

variable "github_repo_url" {
  description = "EpicBook application repository URL"
  type        = string
  default     = "https://github.com/pravinmishraaws/epicbook.git"
}