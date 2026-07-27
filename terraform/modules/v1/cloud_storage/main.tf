resource "google_storage_bucket" "bucket" {

  for_each = var.storage_buckets

  project = var.project_id

  name = each.value.name

  location = each.value.location

  storage_class = each.value.storage_class

  uniform_bucket_level_access = each.value.uniform_bucket_level_access

  force_destroy = each.value.force_destroy

  labels = each.value.labels

  versioning {

    enabled = each.value.versioning

  }

  dynamic "lifecycle_rule" {

    for_each = each.value.lifecycle_rules

    content {

      action {

        type = lifecycle_rule.value.action

      }

      condition {

        age = lifecycle_rule.value.age

      }

    }

  }

}