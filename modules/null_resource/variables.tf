variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)."
  type        = string
}


# variables.tf

variable "scalr_hostname" {
  description = "Scalr hostname, e.g. example.scalr.io"
  type        = string
}

variable "scalr_token" {
  description = "Scalr API token (use a service account token)"
  type        = string
  sensitive   = true
}

variable "scalr_account_id" {
  description = "Scalr account ID, e.g. acc-xxxxxxxxxx"
  type        = string
}

variable "op_service_account_token" {
  description = "1Password service account token"
  type        = string
  sensitive   = true
}
