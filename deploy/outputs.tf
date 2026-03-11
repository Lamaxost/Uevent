output "frontend_url" {
  value       = digitalocean_app.frontend.default_ingress
  description = "The URL where the UEvent UI is hosted"
}

output "backend_url" {
  value       = "https://${var.api_subdomain}.${var.domain_name}"
  description = "The URL for the backend API"
}