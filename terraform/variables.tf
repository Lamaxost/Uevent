variable "ssh_fingerprint" {
  description = "The fingerprint of the SSH key"
  type        = string
}

variable "region" {
  description = "The DigitalOcean region"
  type        = string
  default     = "fra1"
}

variable "project_name" {
  description = "The project name"
  type        = string
  default     = "UEvent"
}

variable "docker_username" {
  type = string
}

data "digitalocean_ssh_key" "default" {
  name = "Fedora"
}
