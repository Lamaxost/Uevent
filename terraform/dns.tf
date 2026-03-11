resource "digitalocean_domain" "main" {
  name = var.domain_name
}

# 3. Request the SSL Certificate (Let's Encrypt)
resource "digitalocean_certificate" "api_cert" {
  name    = var.api_cert_name
  type    = "lets_encrypt"
  domains = ["${var.api_subdomain}.${var.domain_name}"]

  lifecycle {
    prevent_destroy       = true
    create_before_destroy = true
    ignore_changes = [
      name,
    ]
  }

  # Wait for DNS to be ready before trying to issue the cert
  depends_on = [digitalocean_domain.main]
}

resource "digitalocean_record" "api_dns" {
  domain = digitalocean_domain.main.id
  type   = "A"
  name   = var.api_subdomain
  value  = digitalocean_loadbalancer.gateway.ip
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [name]
  }
}
