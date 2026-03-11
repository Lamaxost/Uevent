terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  backend "s3" {
    endpoint = "https://fra1.digitaloceanspaces.com"
    key      = "Uevent/terraform.tfstate"
    region   = "us-east-1"
    bucket   = "terraform-memory"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
  }
}

provider "digitalocean" {
  token = var.do_token
}
