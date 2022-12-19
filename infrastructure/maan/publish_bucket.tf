module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 3.4"

  name       = "maan-artifacts"
  project_id = var.project_id
  location   = "us-east1"
}
