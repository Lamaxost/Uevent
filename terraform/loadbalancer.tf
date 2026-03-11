resource "digitalocean_loadbalancer" "gateway" {
  name     = var.lb_name
  region   = var.region
  vpc_uuid = digitalocean_vpc.uevent_network.id

  # Rule: HTTPS (443) -> Your Custom Port (e.g., 5000)
  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = var.backend_port
    target_protocol = "http"

    certificate_name = digitalocean_certificate.api_cert.name
  }

  # Automatic Redirect: HTTP (80) -> HTTPS (443)
  redirect_http_to_https = true

  healthcheck {
    port     = var.backend_port
    protocol = "http"
    path     = "/health"
  }

  droplet_tag = digitalocean_tag.backend_tag.name
}
