
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.84.0"
    }
  }
}

provider "google" {
  credentials = file("CREDENTIAL.json")
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}
