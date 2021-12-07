
output "ddve_internal-ip" { value = google_compute_instance.ddve.network_interface.0.network_ip }
output "ddve_external-ip" { value = google_compute_address.ddve-external-ip.address }
output "ppdm_internal-ip" { value = google_compute_instance.ppdm.network_interface.0.network_ip }
output "ppdm_external-ip" { value = google_compute_address.ppdm-external-ip.address }
