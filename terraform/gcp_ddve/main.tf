
// A single Compute Engine instance
resource "google_compute_instance" "gcp-ddve01" {
  name         = "gcp-ddve01"
  machine_type = "e2-standard-4"

  boot_disk {
    initialize_params {
      //      image = "dellemc-ddve-public/ddve-gcp-7-4-0-5-671629"
      image = "dellemc-ddve-public/ddve-gcp-7-6-0-5-685135"
      //      type  = "pd-ssd"
      type = "pd-standard"
      size = 250
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.external-ip.address
    }
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

  metadata = {
    serial-port-logging-enable = "true"
  }
}

resource "google_compute_disk" "ddve-nvram" {
  name = "ddve-nvram"
  type = "pd-standard"
  size = 10
}
resource "google_compute_disk" "ddve-metadata-1" {
  name = "ddve-metadata-1"
  type = "pd-standard"
  size = 100
}

resource "google_compute_attached_disk" "attaced-ddve-nvram" {
  disk     = google_compute_disk.ddve-nvram.id
  instance = google_compute_instance.gcp-ddve01.id
}
resource "google_compute_attached_disk" "attached-ddve-metadata-1" {
  disk     = google_compute_disk.ddve-metadata-1.id
  instance = google_compute_instance.gcp-ddve01.id
}

resource "google_compute_address" "external-ip" {
  project      = var.gcp_project
  region       = var.gcp_region
  name         = "external-ip"
  address_type = "EXTERNAL"
}

/*
resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}
*/

resource "local_file" "tf_ansible_vars_file" {
  content  = <<-DOC
    tf_ddve_ip: ${google_compute_address.external-ip.address}
    tf_ddve_instance_id: ${google_compute_instance.gcp-ddve01.instance_id}
    DOC
  filename = "/home/bhaven/terraform/ansible/gcp_tf_ansible_vars_file.yaml"
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "ansible-playbook /home/bhaven/terraform/ansible/ddve.yaml"
  }

  depends_on = [google_compute_instance.gcp-ddve01]
}
