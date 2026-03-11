output "frontend_url" {
  value       = digitalocean_app.frontend.default_ingress
  description = "The URL where the UEvent UI is hosted"
}

output "backend_url" {
  value       = "https://${var.api_subdomain}.${var.domain_name}"
  description = "The URL for the backend API"
}

output "backend_droplet_ids" {
  value       = digitalocean_droplet.backend_server[*].id
  description = "The IDs of the backend droplets"
}

output "db_host" {
  value       = digitalocean_database_cluster.postgres.private_host
  description = "The host of the database"
}
output "db_port" {
  value       = digitalocean_database_cluster.postgres.port
  description = "The port of the database"
}
output "db_username" {
  value       = digitalocean_database_cluster.postgres.user
  description = "The username of the database"
}
output "db_password" {
  value       = digitalocean_database_cluster.postgres.password
  description = "The password of the database"
  sensitive = true
}
output "db_name" {
  value       = digitalocean_database_cluster.postgres.database
  description = "The name of the database"
}