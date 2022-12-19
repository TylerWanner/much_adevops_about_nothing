terraform {
  backend "gcs" {
    bucket = "maan-terraform-admin"
    prefix = "maan"
  }
} 