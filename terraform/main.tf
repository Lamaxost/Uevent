resource "digitalocean_app" "frontend" {
  spec {
    name   = "uevent-frontend"
    region = "fra"

    static_site {
      name          = "web-ui"
      source_dir    = "/services/frontend"
      build_command = "npm install && npm run build"
      output_dir    = "out"

      # THIS IS THE MAGIC:
      # We inject the Load Balancer IP into the React Build
      env {
        key   = "VITE_API_URL"
        value = "123"
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
