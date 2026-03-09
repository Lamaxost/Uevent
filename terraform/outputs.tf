output "frontend_url" {
  value       = digitalocean_app.frontend.default_ingress
  description = "The URL where the Ticketmaster UI is hosted"
}
