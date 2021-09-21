

output "instance_internal-ip" { value = google_compute_instance.gcp-ddve01.network_interface.0.network_ip }
output "instance_external-ip" { value = google_compute_address.external-ip.address }
output "instance_name" { value = google_compute_instance.gcp-ddve01.name }
output "instance_id" { value = google_compute_instance.gcp-ddve01.instance_id }
