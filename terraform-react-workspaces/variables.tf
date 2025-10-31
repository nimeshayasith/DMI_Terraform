variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "react-app-workspaces"
}

variable "owner_email" {
  description = "Email of the infrastructure owner"
  type        = string
  default     = "nimeshayasith@gmail.com"
}

# Node.js version for the app
variable "node_version" {
  description = "Node.js version for the web app"
  type        = string
  default     = "18-lts"
}

# Deployment configuration
variable "zip_deploy_file" {
  description = "Path to the zip file for deployment"
  type        = string
  default     = ""
}