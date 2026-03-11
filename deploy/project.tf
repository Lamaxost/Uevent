data "digitalocean_project" "existing_uevent" {
  name = var.project_name
}

resource "digitalocean_project_resources" "uevent_assets" {
  project = data.digitalocean_project.existing_uevent.id

  resources = concat(
    [
      digitalocean_domain.main.urn,
      digitalocean_database_cluster.postgres.urn,
      digitalocean_loadbalancer.gateway.urn,
      digitalocean_app.frontend.urn
    ],
    digitalocean_droplet.backend_server[*].urn
  )
}
