resource "google_bigquery_dataset" "datasets" {

  for_each = var.bigquery

  project = var.project_id

  dataset_id = each.value.dataset_id

  location = each.value.location

  labels = each.value.labels

  delete_contents_on_destroy = each.value.delete_contents_on_destroy

  default_table_expiration_ms = try(each.value.default_table_expiration_ms, null)

}

locals {

  tables = merge([

    for dataset_key, dataset in var.bigquery : {

      for table_key, table in dataset.tables :

      "${dataset_key}-${table_key}" => {

        dataset_key = dataset_key

        dataset_id = dataset.dataset_id

        table = table

      }

    }

  ]...)

}

resource "google_bigquery_table" "tables" {

  for_each = local.tables

  project = var.project_id

  dataset_id = google_bigquery_dataset.datasets[each.value.dataset_key].dataset_id

  table_id = each.value.table.table_id

  deletion_protection = each.value.table.deletion_protection

  schema = file("${path.module}/schemas/${each.value.table.schema_file}")

  dynamic "time_partitioning" {

    for_each = each.value.table.time_partitioning == null ? [] : [1]

    content {

      type = each.value.table.time_partitioning.type

      field = try(each.value.table.time_partitioning.field, null)

    }

  }

  clustering = each.value.table.clustering

}

