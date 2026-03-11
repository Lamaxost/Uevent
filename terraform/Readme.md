# UEvent Infrastructure

This repository contains the Terraform infrastructure code required to deploy the UEvent application on DigitalOcean. It automates the provisioning of Droplets (servers), a PostgreSQL Database, a Load Balancer, a Static Site (React/Vite), Domains, and an SSL Certificate.

## Prerequisites

Before deploying this infrastructure, ensure you have the following ready:

1. **DigitalOcean Account**: You need an active account and a Personal Access Token (API token).
2. **Space / S3 Bucket**: You must have a DigitalOcean Space named `terraform-memory` (or change it in `provider.tf`) located in your desired region to store Terraform's remote state.
3. **DO Spaces Access Keys**: You must generate an Access Key and a Secret Key for your DigitalOcean Space.
4. **SSH Key Added**: Ensure your public SSH key is added to your DigitalOcean account under _Settings > Security_. Name it accordingly (the default expects "Fedora", but that can be adjusted).
5. **Docker Hub Repository**: The backend droplets pull a pre-built backend Docker image. Ensure your backend image (e.g., `your_docker_username/uevent-backend:latest`) exists on Docker Hub.
6. **Domain Name**: This infrastructure assumes you manage a domain (e.g., `uvent-campus.xyz`) inside your DigitalOcean account. **IMPORTANT: Your domain MUST be pointed to DigitalOcean's nameservers (`ns1.digitalocean.com`, `ns2.digitalocean.com`, `ns3.digitalocean.com`) for the DNS and SSL certificate provisioning to work.**

## Customizing the Deployment Defaults

1. **Copy Example Variables**: Duplicate `terraform.example.tfvars` into a new file named `terraform.tfvars`.
2. **Fill in the Variables**: Open `terraform.tfvars` and inject your specific values (API tokens, keys, domain name, docker username, resource names, etc.). _Never commit this file to version control._
3. **Adjust Provider Configuration (`provider.tf`)**: Check `provider.tf`. Ensure the bucket name, endpoint, and region correctly correspond to the DigitalOcean Space you created for storing remote state.

## Deployment Guide

### 1. Initialize the S3 Backend Strategy

Because the backend state is stored securely in an S3-compatible space, you cannot pass your secret keys dynamically through `.tfvars`.

You **MUST** initialize the Terraform directory with your Space authentication keys via the command line using `-backend-config` arguments.

Execute the following command (replacing `MY_ACCESS_KEY` and `MY_SECRET_KEY` with your actual Space tokens):

```bash
terraform init \
  -backend-config="access_key=MY_ACCESS_KEY" \
  -backend-config="secret_key=MY_SECRET_KEY" \
  -reconfigure
```

_Note: The `-reconfigure` flag is highly recommended to ensure your backend establishes fresh connections safely without carrying over potentially conflicting stale caches._

### 2. Verify the Configuration

Verify your configuration's health by running formatting and validation checks.

```bash
terraform validate
```

### 3. Review the Deployment Plan

Generate an execution plan to see exactly what DigitalOcean resources will be created, modified, or destroyed.

```bash
terraform plan
```

Ensure everything aligns with your expectations. Check that Droplets, the Database, the Load Balancer, and the Frontend App show up cleanly.

### 4. Deploy

Apply the configuration!

```bash
terraform apply
```

Type `yes` when prompted. Wait for the provisioning sequence to finish. This process can take a few minutes (especially the Database Cluster mapping).

### 5. Access Your Applications

Once deployment completes, Terraform outputs two key endpoints:

- `frontend_url`: The public hostname of your VITE-powered React frontend instance. though it is also accesed from yourdomain.com
- `backend_url`: The load-balanced API address (which resolves to `.api.yourdomain.com`).
