data "google_project" "project" {}

resource "google_project_service" "kafka_api" {
  service            = "managedkafka.googleapis.com"
  project            = data.google_project.project.project_id
  disable_on_destroy = false
}

resource "google_managed_kafka_cluster" "example" {
  cluster_id = var.cluster_id
  location   = var.region

  capacity_config {
    vcpu_count   = var.vcpu_count
    memory_bytes = var.memory_bytes
  }

  gcp_config {
    access_config {
      network_configs {

        subnet = var.subnet
        # subnet = "projects/${data.google_project.project.project_id}/regions/${var.region}/subnetworks/${var.subnet_name}"
      }
    }
  }

  rebalance_config {
    mode = var.rebalance_mode
  }
  lifecycle {
    ignore_changes = [labels]
  }
}
resource "google_kms_crypto_key_iam_member" "kafka_kms_access" {
  crypto_key_id = var.kms_key_id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-managedkafka.iam.gserviceaccount.com"

  depends_on = [google_project_service.kafka_api]
}


## use below blocks if you want to fetch the subnet information dynamically
# data "google_compute_subnetwork" "selected" {
#   name    = var.subnet_name
#   region  = var.region
#   project = data.google_project.project.project_id
# }

# subnet = data.google_compute_subnetwork.selected.id 