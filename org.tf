###########################
## Org Policy External IP
###########################

resource "google_organization_policy" "external_ip_policy" {
  org_id   = var.org_id
  constraint = "compute.vmExternalIpAccess"

  list_policy {
    deny {
      all = true
    }
  }
}

###########################
## VPC Service Controls
###########################

locals {
  access_policy = "accessPolicies/${google_access_context_manager_access_policy.access_policy.name}"
  access_level_name = "${local.access_policy}/accessLevels/terraform_allowed"
}

resource "google_access_context_manager_access_policy" "access_policy" {
  provider = "google"
  parent   = "organizations/${var.org_id}"
  title    = "Test Policy"
}

resource "google_access_context_manager_access_level" "terraform_access" {
  parent      = local.access_policy
  name        = local.access_level_name 
  title       = "chromeos_no_lock"
  basic {
    conditions {
      members = ["serviceAccount:${var.terraform_service_account}"]
    }
  }
}

data "google_project" "project1" {
  project_id = var.project1_id
}

resource "google_access_context_manager_service_perimeter" "regular_service_perimeter" {
  provider       = "google"
  parent         = local.access_policy
  perimeter_type = "PERIMETER_TYPE_REGULAR"
  name           = "${local.access_policy}/servicePerimeters/${var.perimeter_name}"
  title          = "${var.perimeter_name}"

  status {
    restricted_services = ["bigquery.googleapis.com", "storage.googleapis.com"]
    resources           = ["projects/${data.google_project.project1.number}"]
    access_levels       = [local.access_level_name]
  }
}
