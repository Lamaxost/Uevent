# -----------------------------------------------------
# 1. Provider Authentication & Core
# -----------------------------------------------------
variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
}

variable "access_key" {
  description = "Access key for spaces/backend"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Secret key for spaces/backend"
  type        = string
  sensitive   = true
}

variable "ssh_fingerprint" {
  description = "The fingerprint of the SSH key"
  type        = string
}

data "digitalocean_ssh_key" "default" {
  name = "Fedora"
}

# -----------------------------------------------------
# 2. Platform & Region
# -----------------------------------------------------
variable "region" {
  description = "The DigitalOcean region"
  type        = string
  default     = "fra1"
}

variable "project_name" {
  description = "The project name"
  type        = string
  default     = "uevent"
}

variable "docker_username" {
  description = "Docker Hub Username"
  type        = string
}

# -----------------------------------------------------
# 4. General Networking
# -----------------------------------------------------
variable "vpc_name" {
  description = "The name of the DigitalOcean VPC"
  type        = string
  default     = "uevent-vpc"
}

# -----------------------------------------------------
# 5. Load Balancer & Backend Access
# -----------------------------------------------------
variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
  default     = "uevent-gateway"
}

variable "backend_port" {
  description = "The port the backend API runs on"
  type        = number
  default     = 5000
}

# -----------------------------------------------------
# 6. Domain & Certificate
# -----------------------------------------------------
variable "domain_name" {
  description = "The root domain name for the application"
  type        = string
  default     = "uvent-campus.xyz"
}

variable "api_subdomain" {
  description = "Subdomain prefix for the API"
  type        = string
  default     = "api"
}

variable "api_cert_name" {
  description = "Name for the API SSL Certificate"
  type        = string
  default     = "uevent-api-cert"
}

# -----------------------------------------------------
# 7. Server & Database Resource Names
# -----------------------------------------------------
variable "backend_tag_name" {
  description = "Tag name for backend resources"
  type        = string
  default     = "uevent-backend"
}

variable "backend_droplet_prefix" {
  description = "Prefix for the backend droplet names"
  type        = string
  default     = "uevent-backend"
}

variable "db_cluster_name" {
  description = "Name for the Database Cluster"
  type        = string
  default     = "uevent-db"
}

# -----------------------------------------------------
# 8. Frontend Application
# -----------------------------------------------------
variable "frontend_app_name" {
  description = "Name of the DigitalOcean frontend app"
  type        = string
  default     = "uevent-frontend"
}

variable "frontend_site_name" {
  description = "Name for the static site component"
  type        = string
  default     = "web-ui"
}

variable "github_repo" {
  description = "GitHub repository for frontend deployment (e.g., owner/repo)"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to deploy from"
  type        = string
  default     = "main"
}
