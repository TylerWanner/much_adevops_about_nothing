module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 6.0.0"

  project_id   = var.project_id
  network_name = "example-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "main"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.region
    },
  ]

  secondary_ranges = {}

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}
module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 4.0"
  project = var.project_id # Replace this with your project ID in quotes
  name    = "my-cloud-router"
  network = "example-vpc"
  region  = "us-east1"

  nats = [{
    name = "my-nat-gateway"
  }]
}

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = [{
    name                    = "allow-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22", "8080"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}