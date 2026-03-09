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
