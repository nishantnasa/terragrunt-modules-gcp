terraform {
  backend "gcs" {}
}

locals {
  project_main_sa = [
    [ "serviceAccount:${var.product_name}-${var.env}@${var.project_id}.iam.gserviceaccount.com" ]
  ]
  subnetwork_uri = var.subnetwork_uri == "" ? "${var.product_name}-${var.env}-usce1-subnet" : var.subnetwork_uri
  service_account = var.service_account == "" ? "${var.product_name}-${var.env}@${var.project_id}.iam.gserviceaccount.com" : var.service_account
}

# Enable CloudSQL Admin API
module cmd_template_project_services {
  source = "git::git@bitbucket.org:wx_rds/terraform-module-gcp-project-config.git//project_services?ref=master"

  project_id = var.project_id
  activate_apis = jsonencode([
    "sqladmin.googleapis.com"
  ])
}

# Migrate CMD DataProc Workflow Template
data "template_file" "cmd_workflow_template" {
  template = "${file("./pivoter.yml.tmpl")}"
  vars = {
    project_id   = var.project_id
    product_name = var.product_name
    env = var.env
    releaseBucketLocation = var.release_bucket_location
    zoneUri = var.zone_uri
    subnetworkUri = local.subnetwork_uri
    serviceAccount = local.service_account
    dataprocInitBucketLocation = var.dataproc_init_bucket_location
  }
}

resource "local_file" "cmd_workflow_template_yaml" {
  content_base64 = base64encode(data.template_file.cmd_workflow_template.rendered)
  filename = "${path.module}/cmd_pivoter.yml"
}

module shell_cmd_workflow_template_migrator {
  source = "git::git@bitbucket.org:wx_rds/terraform-module-shell.git?ref=master"

  depends = [
    local_file.cmd_workflow_template_yaml
  ]

  shell_environment = var.shell_environment

  command              = <<EOC
    ${path.module}/activate-gcloud-project.sh;
    gcloud --quiet dataproc workflow-templates import ${var.product_name}-${var.env}-cmd2-pivoter --region ${var.region} --source=cmd_pivoter.yml --project=${var.project_id} && echo 'CMD Pivoter Dataproc Workflow Template deployed to ${var.product_name}-${var.env} GCP Project';
  EOC

  command_when_destroy = <<EOC
  ${path.module}/activate-gcloud-project.sh;
  (gcloud --quiet dataproc workflow-templates delete ${var.product_name}-${var.env}-cmd2-pivoter --region ${var.region} --project=${var.project_id} || true) && echo 'CMD Pivoter Dataproc Workflow Template deleted from ${var.product_name}-${var.env} GCP Project';
  EOC
}

# wx-bq-poc iam bindings for CMD Dataproc Workflow Template
module cmd_template_storage_bucket_bindings {
  source = "git::git@bitbucket.org:wx_rds/terraform-module-gcp-iam.git//storage_bucket_bindings?ref=master"

  bindings = [
    {
      entity = "de-prd-releases",
      role = "projects/wx-bq-poc/roles/customCmdTemplateStorageReader",
      members = local.project_main_sa,
      mode = "additive"
    },
    {
      entity = "wx-prod-hive",
      role = "projects/wx-bq-poc/roles/customCmdTemplateStorageReader",
      members = local.project_main_sa,
      mode = "additive"
    },
    {
      entity = "wx-lty-data-sync-hive-prod"
      role = "projects/wx-bq-poc/roles/customCmdTemplateStorageReader"
      members = local.project_main_sa
      mode = "additive"
    },
  ]
}

module cmd_template_project_bindings {
  source = "git::git@bitbucket.org:wx_rds/terraform-module-gcp-iam.git//project_bindings?ref=master"

  bindings = [
    {
      entity = "wx-bq-poc",
      role = "projects/wx-bq-poc/roles/customCmdTemplateRunner",
      members = local.project_main_sa,
      mode = "additive"
    },
  ]
}
