locals {
  project_defaults = [
    {
      role_id = "customBillingViewer",
      title = "Custom Billing Viewer",
      permissions = [
        "billing.resourceCosts.get",
        "resourcemanager.projects.get"
      ],
      stage = ""
    },
    {
      role_id = "customServiceAccountViewer",
      title = "Custom Service Account Viewer",
      permissions = [
        "iam.serviceAccounts.get",
        "iam.serviceAccounts.list"
      ],
      stage = ""
    },
    {
      role_id = "customStorageReader",
      title = "Custom Storage Reader",
      permissions = [
        "storage.buckets.get",
        "storage.buckets.list",
        "storage.objects.get",
        "storage.objects.list"
      ],
      stage = ""
    },
    {
      role_id = "customStorageWriter",
      title = "Custom Storage Writer",
      permissions = [
        "storage.buckets.get",
        "storage.buckets.list",
        "storage.objects.create",
        "storage.objects.get",
        "storage.objects.list",
        "storage.objects.update",
      ],
      stage = ""
    },
    {
      role_id = "customStorageDeleter",
      title = "Custom Storage Deleter",
      permissions = [
        "storage.buckets.get",
        "storage.buckets.list",
        "storage.objects.create",
        "storage.objects.delete",
        "storage.objects.get",
        "storage.objects.list",
        "storage.objects.update",
      ],
      stage = ""
    },
    {
      role_id = "customBqUser",
      title = "Custom BigQuery User",
      permissions = [
        "bigquery.datasets.get",
        "bigquery.datasets.update",
        "bigquery.datasets.getIamPolicy",
        "bigquery.jobs.create",
        "bigquery.jobs.get",
        "bigquery.jobs.list",
        "bigquery.jobs.listAll",
        "bigquery.jobs.update",
        "bigquery.models.list",
        "bigquery.readsessions.create",
        "bigquery.readsessions.getData",
        "bigquery.readsessions.update",
        "bigquery.routines.list",
        "bigquery.savedqueries.create",
        "bigquery.savedqueries.delete",
        "bigquery.savedqueries.get",
        "bigquery.savedqueries.list",
        "bigquery.savedqueries.update",
        "bigquery.tables.list",
        "bigquery.transfers.get",
        "bigquery.transfers.update",
      ],
      stage = ""
    },
    {
      role_id = "customBqDataEditor",
      title = "Custom BigQuery Data Editor",
      permissions = [
          "bigquery.datasets.get",
          "bigquery.datasets.getIamPolicy",
          "bigquery.datasets.updateTag",
          "bigquery.models.create",
          "bigquery.models.delete",
          "bigquery.models.export",
          "bigquery.models.getData",
          "bigquery.models.getMetadata",
          "bigquery.models.list",
          "bigquery.models.updateData",
          "bigquery.models.updateMetadata",
          "bigquery.models.updateTag",
          "bigquery.routines.create",
          "bigquery.routines.delete",
          "bigquery.routines.get",
          "bigquery.routines.list",
          "bigquery.routines.update",
          "bigquery.tables.create",
          "bigquery.tables.delete",
          "bigquery.tables.export",
          "bigquery.tables.get",
          "bigquery.tables.getData",
          "bigquery.tables.getIamPolicy",
          "bigquery.tables.list",
          "bigquery.tables.update",
          "bigquery.tables.updateData",
          "bigquery.tables.updateTag",
      ],
      stage = ""
    },
  ]
}
