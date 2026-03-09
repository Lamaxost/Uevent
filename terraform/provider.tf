terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0" # Use the latest version 2.x
    }
  }
  backend "s3" {
    endpoint = "https://fra1.digitaloceanspaces.com"
    region   = "us-east-1"
    bucket   = "terraform-memory"
    key      = "Uevent/terraform.tfstate"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
  }
}
variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}
