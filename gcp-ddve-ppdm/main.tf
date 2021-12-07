
// DDVE Instance
resource "google_compute_instance" "ddve" {
  name         = var.ddve_hostname
  machine_type = var.ddve_machine_type

  boot_disk {
    initialize_params {
      image = "dellemc-ddve-public/ddve-gcp-${var.ddve_version}"
      type  = var.gcp_disktype
      size  = 250
    }
  }
  attached_disk {
    source      = google_compute_disk.ddve-nvram.name
    device_name = "${var.ddve_hostname}-nvram"
  }
  network_interface {
    network    = var.ddve_network
    subnetwork = var.ddve_subnetwork
    access_config {
      nat_ip = google_compute_address.ddve-external-ip.address
    }
  }
  lifecycle {
    ignore_changes = [attached_disk]
  }
  metadata = {
    serial-port-logging-enable = "true"
    serial-port-enable         = "true"
  }
  tags = [var.ddve_hostname]
}

resource "google_compute_disk" "ddve-nvram" {
  name = "${var.ddve_hostname}-nvram"
  type = var.gcp_disktype
  size = 10
}
resource "google_compute_disk" "ddve-metadata-1" {
  name = "${var.ddve_hostname}-metadata-1"
  type = var.gcp_disktype
  size = 200
}
resource "google_compute_attached_disk" "attached-ddve-metadata-1" {
  disk     = google_compute_disk.ddve-metadata-1.id
  instance = google_compute_instance.ddve.id
}
resource "google_compute_address" "ddve-external-ip" {
  project      = var.gcp_project
  region       = var.gcp_region
  name         = "${var.ddve_hostname}-external-ip"
  address_type = "EXTERNAL"
}

resource "google_compute_firewall" "ddve-ingress" {
  name      = "${var.ddve_hostname}-ingress"
  network   = var.ddve_network
  direction = "INGRESS"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["21-23", "80", "111", "139", "389", "443", "445", "464", "2049", "2051", "2052", "3008", "3009", "5001"]
  }
  allow {
    protocol = "udp"
    ports    = ["111", "123", "137", "161"]
  }
  target_tags = [var.ddve_hostname]
  depends_on  = [google_compute_instance.ddve]
}

// PPDM instance
resource "google_compute_instance" "ppdm" {
  name         = var.ppdm_hostname
  machine_type = var.ppdm_machine_type

  boot_disk {
    initialize_params {
      image = "dellemc-ddve-public/powerprotect-boot-${var.ppdm_version}"
      type  = var.gcp_disktype
      size  = 98
    }
  }
  network_interface {
    network    = var.ppdm_network
    subnetwork = var.ppdm_subnetwork
    access_config {
      nat_ip = google_compute_address.ppdm-external-ip.address
    }
  }
  lifecycle {
    ignore_changes = [attached_disk]
  }
  metadata = {
    serial-port-logging-enable = "true"
    serial-port-enable         = "true"
  }
  tags = [var.ppdm_hostname]
}

resource "google_compute_disk" "ppdm-data1" {
  name  = "${var.ppdm_hostname}-data1"
  type  = var.gcp_disktype
  image = "dellemc-ddve-public/powerprotect-data1-${var.ppdm_version}"
  size  = 498
}
resource "google_compute_disk" "ppdm-data2" {
  name  = "${var.ppdm_hostname}-data2"
  type  = var.gcp_disktype
  image = "dellemc-ddve-public/powerprotect-data2-${var.ppdm_version}"
  size  = 10
}
resource "google_compute_disk" "ppdm-data3" {
  name  = "${var.ppdm_hostname}-data3"
  type  = var.gcp_disktype
  image = "dellemc-ddve-public/powerprotect-data3-${var.ppdm_version}"
  size  = 10
}
resource "google_compute_disk" "ppdm-data4" {
  name  = "${var.ppdm_hostname}-data4"
  type  = var.gcp_disktype
  image = "dellemc-ddve-public/powerprotect-data4-${var.ppdm_version}"
  size  = 5
}
resource "google_compute_disk" "ppdm-data5" {
  name  = "${var.ppdm_hostname}-data5"
  type  = var.gcp_disktype
  image = "dellemc-ddve-public/powerprotect-data5-${var.ppdm_version}"
  size  = 5
}
resource "google_compute_disk" "ppdm-data6" {
  name  = "${var.ppdm_hostname}-data6"
  type  = var.gcp_disktype
  image = "dellemc-ddve-public/powerprotect-data6-${var.ppdm_version}"
  size  = 5
}
resource "google_compute_attached_disk" "attached-ppdm-data1" {
  disk     = google_compute_disk.ppdm-data1.id
  instance = google_compute_instance.ppdm.id
}
resource "google_compute_attached_disk" "attached-ppdm-data2" {
  disk     = google_compute_disk.ppdm-data2.id
  instance = google_compute_instance.ppdm.id
}
resource "google_compute_attached_disk" "attached-ppdm-data3" {
  disk     = google_compute_disk.ppdm-data3.id
  instance = google_compute_instance.ppdm.id
}
resource "google_compute_attached_disk" "attached-ppdm-data4" {
  disk     = google_compute_disk.ppdm-data4.id
  instance = google_compute_instance.ppdm.id
}
resource "google_compute_attached_disk" "attached-ppdm-data5" {
  disk     = google_compute_disk.ppdm-data5.id
  instance = google_compute_instance.ppdm.id
}
resource "google_compute_attached_disk" "attached-ppdm-data6" {
  disk     = google_compute_disk.ppdm-data6.id
  instance = google_compute_instance.ppdm.id
}
resource "google_compute_address" "ppdm-external-ip" {
  project      = var.gcp_project
  region       = var.gcp_region
  name         = "${var.ppdm_hostname}-external-ip"
  address_type = "EXTERNAL"
}

resource "google_compute_firewall" "ppdm-ingress" {
  name      = "${var.ppdm_hostname}-ingress"
  network   = var.ppdm_network
  direction = "INGRESS"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "7000", "14443", "7444", "8443"]
  }
  target_tags = [var.ppdm_hostname]
  depends_on  = [google_compute_instance.ppdm]
}

resource "local_file" "tf_ansible_vars_file" {
  content  = <<-DOC
    tf_ddve_external_ip: ${google_compute_address.ddve-external-ip.address}
    tf_ddve_instance_id: ${google_compute_instance.ddve.instance_id}
    tf_ddve_internal_ip: ${google_compute_instance.ddve.network_interface.0.network_ip}
    tf_ddve_password: ${var.ddve_password}
    tf_ddve_hostname: ${var.ddve_hostname}
    tf_ppdm_external_ip: ${google_compute_address.ppdm-external-ip.address}
    tf_ppdm_internal_ip: ${google_compute_instance.ppdm.network_interface.0.network_ip}
    tf_ppdm_common_password: ${var.ppdm_common_password}
    tf_ppdm_hostname: ${var.ppdm_hostname}
    DOC
  filename = "./gcp_tf_ddve-ppdm_ansible_vars_file.yaml"
}

resource "null_resource" "running_ansible_playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook ./ddve-ppdm.yaml"
  }
  depends_on = [google_compute_instance.ddve, google_compute_instance.ppdm, local_file.tf_ansible_vars_file]
}
