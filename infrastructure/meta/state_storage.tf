module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 3.4"

  name       = "maan-terraform-admin"
  project_id = var.project_id
  location   = "us-east1"
}

module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 4.1"
  project_id    = var.project_id
  prefix        = "terraform-admin"
  names         = ["maan"]
  project_roles = [
    # "${var.project_id}=>roles/storage.admin",
    # "${var.project_id}=>roles/iam.serviceAccountAdmin",
    # "${var.project_id}=>roles/iam.serviceAccountKeyAdmin",
    "${var.project_id}=>roles/owner",
    "${var.project_id}=>roles/storage.admin",
  ]
  generate_keys = true
}

output "key" { 
  value = jsondecode(module.service_accounts.key)
  sensitive = true
}
