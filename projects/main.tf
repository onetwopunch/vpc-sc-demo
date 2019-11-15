module "project1" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 4.0"

  name              = "vpc-sc-demo-project-1"
  random_project_id = true
  org_id            = var.org_id
  billing_account   = var.billing_account
  folder_id         = var.folder_id
  activate_apis    = var.enabled_apis
}

module "project2" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 4.0"

  name              = "vpc-sc-demo-project-2"
  random_project_id = true
  org_id            = var.org_id
  billing_account   = var.billing_account
  folder_id         = var.folder_id
  activate_apis    = var.enabled_apis
}
