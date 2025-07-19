variable "region" {
  description = "GCP Region to deploy Kafka cluster"
  type        = string
  default     = "asia-south1"
}

variable "cluster_id" {
  description = "ID for the Kafka cluster"
  type        = string
}

variable "vcpu_count" {
  description = "Number of vCPUs for Kafka broker capacity"
  type        = number
  default     = 4
}

variable "memory_bytes" {
  description = "Memory in bytes (e.g., 4 GiB = 4294967296)"
  type        = number
  default     = 4294967296
}

variable "subnet" {
  description = "Name of the GCP subnet to use"
  type        = string
}

variable "rebalance_mode" {
  description = "Rebalance mode (e.g., AUTO_REBALANCE_ON_SCALE_UP)"
  type        = string
  default     = "AUTO_REBALANCE_ON_SCALE_UP"
}

variable "kms_key_id" {
  description = "Customer-managed KMS key resource ID"
  type        = string
}

