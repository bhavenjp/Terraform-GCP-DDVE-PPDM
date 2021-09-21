
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.84.0"
    }
  }
}

provider "google" {
  //  project = "trusty-shine-326306"
  //  region  = "asia-southeast1"
  //  zone    = "asia-southeast1-a"
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone

}
