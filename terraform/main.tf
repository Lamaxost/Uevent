data "digitalocean_project" "existing_uevent" {
  name = "uevent"
}

# 2. THE MOVER: Forcibly drags the resources into the existing project
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
resource "digitalocean_tag" "backend_tag" {
  name = "uevent-backend"
}


resource "digitalocean_app" "frontend" {
  spec {
    name   = "uevent-frontend"
    region = "fra"

# Handle the root domain (uvent-campus.xyz)
    domain {
      name = digitalocean_domain.main.name
      type = "PRIMARY"
      zone = digitalocean_domain.main.name # <--- AUTOMATION MAGIC
    }
    static_site {
      name          = "web-ui"
      source_dir    = "/services/frontend"
      build_command = "npm install && npm run build"
      output_dir    = "out"

      # THIS IS THE MAGIC:
      # We inject the Load Balancer IP into the React Build
      env {
        key   = "VITE_API_URL"
        value = "https://api.${digitalocean_domain.main.name}"
        # value = "http://${digitalocean_loadbalancer.gateway.ip}"
        type = "GENERAL"
      }

      github {
        repo           = "Lamaxost/Uevent"
        branch         = "main"
        deploy_on_push = true
      }
    }
  }
}


resource "digitalocean_vpc" "uevent_network" {
  name     = "uevent-vpc"
  region   = "fra1"
  ip_range = "10.10.10.0/24"
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [name]
  }
}

resource "digitalocean_domain" "main" {
  name = "uvent-campus.xyz"
}

# 3. Request the SSL Certificate (Let's Encrypt)
resource "digitalocean_certificate" "api_cert" {
  name    = "uevent-api-cert"
  type    = "lets_encrypt"
  domains = ["api.uvent-campus.xyz"] # This MUST be a subdomain of the domain above

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
  name   = "api" # This creates the 'api' in api.yourdomain.com
  value  = digitalocean_loadbalancer.gateway.ip
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [name]
  }
}



resource "digitalocean_loadbalancer" "gateway" {
  name     = "uevent-gateway"
  region   = "fra1"
  vpc_uuid = digitalocean_vpc.uevent_network.id

  # Rule: HTTPS (443) -> Your Custom Port (e.g., 5000)
  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 5000 # <--- PUT YOUR BACKEND PORT HERE
    target_protocol = "http"

    certificate_name = digitalocean_certificate.api_cert.name
  }

  # Automatic Redirect: HTTP (80) -> HTTPS (443)
  redirect_http_to_https = true

  healthcheck {
    port     = 5000 # Must match your backend port
    protocol = "http"
    path     = "/health"
  }

  droplet_tag = digitalocean_tag.backend_tag.name
}

resource "digitalocean_droplet" "backend_server" {
  count  = 2 # Creates two identical servers: backend-0 and backend-1
  name   = "uevent-backend-${count.index}"
  region = "fra1"
  size   = "s-1vcpu-1gb" # The $6/mo starter size
  image  = "ubuntu-24-04-x64"

  # Connect to the Private Network we defined earlier
  vpc_uuid = digitalocean_vpc.uevent_network.id

  # Apply the Tag so the Load Balancer can find them
  tags = [digitalocean_tag.backend_tag.id]

  # Your SSH Key (Ensure this matches your digitalocean_ssh_key resource name)
  ssh_keys = [data.digitalocean_ssh_key.default.id]

  # 3. The "Automation" script to start your app
  user_data = <<-EOF
            #!/bin/bash
            # 1. Install Docker and Netcat
            apt-get update
            apt-get install -y docker.io netcat-openbsd
            systemctl start docker
            systemctl enable docker

            # 2. Variables from Terraform
            DB_HOST="${digitalocean_database_cluster.postgres.private_host}"
            DB_PORT="${digitalocean_database_cluster.postgres.port}"

            # 3. Wait for Database to be reachable
            echo "Waiting for database at $DB_HOST:$DB_PORT..."
            while ! nc -z $DB_HOST $DB_PORT; do
              sleep 2
              echo "Database not ready yet..."
            done
            echo "Database is UP!"

            # 4. Pull and Run Backend
            docker pull ${var.docker_username}/uevent-backend:latest
            
            docker run -d \
              --name backend-api \
              --restart always \
              -p 5000:3000 \
              -e DB_HOST="${digitalocean_database_cluster.postgres.private_host}" \
              -e DB_PORT="${digitalocean_database_cluster.postgres.port}" \
              -e DB_USERNAME="${digitalocean_database_cluster.postgres.user}" \
              -e DB_PASSWORD="${digitalocean_database_cluster.postgres.password}" \
              -e DB_NAME="${digitalocean_database_cluster.postgres.database}" \
              ${var.docker_username}/uevent-backend:latest
            EOF
}

resource "digitalocean_database_cluster" "postgres" {
  name       = "uevent-db"
  engine     = "pg"
  version    = "16" # version number
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
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
