# VPC Service Controls Demo

## Dependencies

* `gcloud/bq`
* Org Admin Role

## Setup

There's a few steps needed to get this demo up and running properly or you'll have a difficult time setting it up later

1. Create a Seed Project
2. Use the [project factory helper script](https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/helpers/setup-sa.sh) to create a Service Account in your seed 
3. Since this service account will be creating BigQuery Datasets and Storage Buckets as well as VPC Service Control perimeters, it'll need a few more permissions. At the Org level, add `Access Context Manager Admin`, and at the Folder level, add `BigQuery Admin` and `Storage Admin` to the seed project Service Account.
4. Run `cp terraform.tfvars.sample terraform.tfvars` and then update that file with your own values.

Now you should be good to go. If not please create an issue detailing your problem so I can update this guide.

## Deployment

Since we have to first create the two projects, we have a Makefile that makes applying this easy. Just run:

```
make apply_projects
```

This will apply both source and target projects to test out VPC SC and subsequently write the IDs into the `env.sh`. This file is sourced first before the subsequent `apply`. Now you can run:

```
make apply
```


## Demo

[TODO]
