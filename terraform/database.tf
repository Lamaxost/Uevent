resource "digitalocean_database_cluster" "postgres" {
  name       = var.db_cluster_name
  engine     = "pg"
  version    = "16"
  size       = "db-s-1vcpu-1gb"
  region     = var.region
  node_count = 1

  # Connect it to your private room
  private_network_uuid = digitalocean_vpc.uevent_network.id
}


resource "digitalocean_database_firewall" "db_fw" {
  cluster_id = digitalocean_database_cluster.postgres.id

  rule {
    type  = "tag"
    value = digitalocean_tag.backend_tag.name
  }
}
