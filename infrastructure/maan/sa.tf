module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 4.1"
  project_id    = var.project_id
  prefix        = "maan"
  names         = ["artifact-reader"]
}