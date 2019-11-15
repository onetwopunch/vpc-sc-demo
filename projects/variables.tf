variable "org_id" {
  type = "string"
}

variable "billing_account" {
  type = "string"
}

variable "folder_id" {
  type    = "string"
  default = ""
}

variable "enabled_apis" {
  type = "list"
  default = [
    "iap.googleapis.com",
    "oslogin.googleapis.com",
    "compute.googleapis.com",
    "bigquery-json.googleapis.com",
  ]
}

