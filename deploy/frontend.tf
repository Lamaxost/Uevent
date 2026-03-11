resource "digitalocean_app" "frontend" {
  spec {
    name   = var.frontend_app_name
    region = var.region
    domain {
      name = digitalocean_domain.main.name
      type = "PRIMARY"
      zone = digitalocean_domain.main.name
    }
    static_site {
      name          = var.frontend_site_name
      source_dir    = "/services/frontend"
      build_command = "npm install && npm run build"
      output_dir    = "out"
      env {
        key   = "VITE_API_URL"
        value = "https://${var.api_subdomain}.${var.domain_name}"
        type  = "GENERAL"
      }

      github {
        repo           = var.github_repo
        branch         = var.github_branch
        deploy_on_push = true
      }
    }
  }
}
