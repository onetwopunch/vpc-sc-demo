variable "project1_id" {
  type = "string"
}

variable "project2_id" {
  type = "string"
}

variable "org_id" {
  type = "string"
}

variable "members" {
  type    = "list"
  default = []
}

variable "terraform_service_account" {
  type = "string"
  description = "The Terraform service account email that should still be allowed in the perimeter to create buckets, datasets, etc."
}

variable "perimeter_name" {
  type = "string"
  default = "protect_the_daters"
}

variable "region" {
  type = "string"
  default = "us-west1"
}

variable "zone" {
  type = "string"
  default = "us-west1-a"
}
