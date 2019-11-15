module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  version = "~> 2.0"

  dataset_id        = "project_1_dataset"
  dataset_name      = "project_1_dataset"
  description       = "Some Cars"
  project_id        = var.project1_id
  location          = "US"
  time_partitioning = "DAY"
  tables = [
    {
      table_id = "cars",
      schema   = "fixtures/schema.json",
      labels = {
        env      = "dev"
      },
    }   
  ]
  dataset_labels = {
    env = "dev"
  }
}

resource "null_resource" "load_data" {
  triggers = {
    bq_table = module.bigquery.table_name[0]
  }
  
  provisioner "local-exec" {
    command = <<EOF
      bq load \
      --location=US \
      --format=csv \
      --field_delimiter=';' \
      project_1_dataset.cars \
      gs://${google_storage_bucket.source_bucket.name}/${google_storage_bucket_object.data.output_name}
EOF
  }
}

resource "google_storage_bucket" "source_bucket" {
  project  = var.project1_id
  name     = "${var.project1_id}-source-bucket"
  location = "US"
}

resource "google_storage_bucket_object" "data" {
  name   = "cars.csv"
  source = "fixtures/cars.csv"
  bucket = google_storage_bucket.source_bucket.name
}


resource "google_storage_bucket" "target_bucket" {
  project  = var.project2_id
  name     = "${var.project2_id}-target-bucket"
  location = "US"
}
