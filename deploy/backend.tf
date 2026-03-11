resource "digitalocean_tag" "backend_tag" {
  name = var.backend_tag_name
}

resource "digitalocean_droplet" "backend_server" {
  count  = 2
  name   = "${var.backend_droplet_prefix}-${count.index}"
  region = var.region
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-24-04-x64"

  vpc_uuid = digitalocean_vpc.uevent_network.id
  tags     = [digitalocean_tag.backend_tag.id]
  ssh_keys = [data.digitalocean_ssh_key.default.id]
  user_data = templatefile("${path.module}/backend_droplet_setup.tpl.sh", {
    db_host     = digitalocean_database_cluster.postgres.private_host
    db_port     = digitalocean_database_cluster.postgres.port
    db_username = digitalocean_database_cluster.postgres.user
    db_password = digitalocean_database_cluster.postgres.password
    db_name     = digitalocean_database_cluster.postgres.database
  })
}
