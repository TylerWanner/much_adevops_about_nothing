module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  region          = var.region
  project_id      = var.project_id
  subnetwork      = module.vpc.subnets["${var.region}/main"].self_link
  service_account = {
    email = module.service_accounts.email
    scopes = []
  }
}

module "compute_instance" {
  source              = "terraform-google-modules/vm/google//modules/compute_instance"
  region              = var.region
  zone                = var.zone
  subnetwork          = module.vpc.subnets["${var.region}/main"].self_link
  num_instances       = 1
  hostname            = "instance-simple"
  instance_template   = module.instance_template.self_link
  deletion_protection = false

  access_config = []
}