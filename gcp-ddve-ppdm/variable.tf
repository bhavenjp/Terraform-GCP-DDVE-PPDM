variable "gcp_project" {
  default = ""
}

variable "gcp_region" {
  default = "asia-southeast1"
}

variable "gcp_zone" {
  default = "asia-southeast1-a"
}

variable "ddve_network" {
  default = ""
}

variable "ddve_subnetwork" {
  default = ""
}

variable "ddve_version" {
  default = "7-6-0-5-685135"
}

variable "ddve_hostname" {
  default = "gcp-ddve01"
}

variable "ddve_machine_type" {
  default = "e2-standard-4"
}

variable "ddve_password" {
  default = ""
}

variable "ppdm_network" {
  default = ""
}

variable "ppdm_subnetwork" {
  default = ""
}

variable "ppdm_version" {
  default = "19-9-0-13"
}

variable "ppdm_hostname" {
  default = "gcp-ppdm01"
}

variable "ppdm_machine_type" {
  default = "custom-8-18432"
}

variable "ppdm_common_password" {
  default = ""
}

variable "gcp_disktype" {
  default = "pd-ssd"
}
