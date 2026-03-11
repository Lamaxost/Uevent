# -----------------------------------------------------
# 1. Provider Authentication & Core
# -----------------------------------------------------
do_token             = ""
ssh_fingerprint      = ""
access_key           = ""
secret_key           = ""
github_ci_public_key = ""

# -----------------------------------------------------
# 2. Platform & Region
# -----------------------------------------------------
region          = ""
project_name    = ""
docker_username = ""

# -----------------------------------------------------
# 3. Backend State Parameters
# -----------------------------------------------------
backend_endpoint = ""
backend_key      = ""

# -----------------------------------------------------
# 4. General Networking
# -----------------------------------------------------
vpc_name = ""

# -----------------------------------------------------
# 5. Load Balancer & Backend Access
# -----------------------------------------------------
lb_name      = ""
backend_port = ""

# -----------------------------------------------------
# 6. Domain & Certificate
# -----------------------------------------------------
# domain_name   = ""  # Using default from variables.tf
api_subdomain = ""
api_cert_name = ""

# -----------------------------------------------------
# 7. Server & Database Resource Names
# -----------------------------------------------------
backend_tag_name       = ""
backend_droplet_prefix = ""
db_cluster_name        = ""

# -----------------------------------------------------
# 8. Frontend Application
# -----------------------------------------------------
frontend_app_name  = ""
frontend_site_name = ""
github_repo        = ""
github_branch      = ""