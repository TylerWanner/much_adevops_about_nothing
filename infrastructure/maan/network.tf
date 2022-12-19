module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 6.0.0"

  project_id   = var.project_id
  network_name = "example-vpc"
  routing_mode = "GLOBAL"

  subnets = [
      {
          subnet_name           = "main"
          subnet_ip             = "10.10.10.0/24"
          subnet_region         = var.region
      },
  ]

  secondary_ranges = {}

  routes = [
      {
          name                   = "egress-internet"
          description            = "route through IGW to access internet"
          destination_range      = "0.0.0.0/0"
          tags                   = "egress-inet"
          next_hop_internet      = "true"
      }
  ]
}
output "subnets" {
  value = module.vpc.subnets
}