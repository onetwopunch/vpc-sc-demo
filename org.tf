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

data "google_project" "project1" {
  project_id = var.project1_id
}
module "org_policy" {
  source      = "terraform-google-modules/vpc-service-controls/google"
  version     = "~> 1.0.1"
  parent_id   = var.org_id
  policy_name = "VPC SC Demo Policy"
}

module "access_level_members" {
  source  = "terraform-google-modules/vpc-service-controls/google//modules/access_level"
  version = "~> 1.0.1"
  policy  = module.org_policy.policy_id
  name    = "terraform_members"
  members = ["serviceAccount:${var.terraform_service_account}"]
}

module "regular_service_perimeter_1" {
  source              = "terraform-google-modules/vpc-service-controls/google//modules/regular_service_perimeter"
  version             = "~> 1.0.1"
  policy              = module.org_policy.policy_id
  perimeter_name      = "regular_perimeter_1"
  description         = "Perimeter shielding projects"
  resources           = [data.google_project.project1.number]
  access_levels       = [module.access_level_members.name]
  restricted_services = ["bigquery.googleapis.com", "storage.googleapis.com"]
}

