###########################
## Source Bastion Host
###########################

module "bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "0.2.0"

  project = var.project1_id
  region  = var.region
  zone    = var.zone
  members = var.members
  network = google_compute_network.source_network.self_link
  subnet  = google_compute_subnetwork.source_subnet.self_link
  service_account_roles_supplemental = [
    "roles/bigquery.admin",
    "roles/storage.objectViewer", 
  ]
}

resource "google_compute_network" "source_network" {
  project                 = var.project1_id
  name                    = "test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "source_subnet" {
  project                  = var.project1_id
  name                     = "test-subnet"
  region                   = var.region
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.source_network.self_link
  private_ip_google_access = true
}

######################################
## Simulate Exfil to other GCP project
######################################

resource "google_storage_bucket_iam_member" "bound_from_attacker" {
  bucket  = google_storage_bucket.target_bucket.name
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${module.bastion.service_account}"
}
