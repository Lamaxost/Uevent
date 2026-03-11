resource "digitalocean_vpc" "uevent_network" {
  name     = var.vpc_name
  region   = var.region
  ip_range = "10.10.10.0/24"
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [name]
  }
}
