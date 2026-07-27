resource "google_cloudfunctions2_function" "function" {

  for_each = var.functions

  project = var.project_id

  location = var.region

  name = each.value.name

  build_config {

    runtime = each.value.runtime

    entry_point = each.value.entry_point

    source {

      storage_source {

        bucket = each.value.bucket

        object = each.value.object

      }

    }

  }

  service_config {

    available_memory = each.value.memory

    timeout_seconds = each.value.timeout

    max_instance_count = each.value.max_instances

    service_account_email = each.value.service_account

    environment_variables = each.value.env

  }

  event_trigger {

    trigger_region = var.region

    event_type = "google.cloud.pubsub.topic.v1.messagePublished"

    pubsub_topic = each.value.pubsub_topic

    retry_policy = "RETRY_POLICY_RETRY"

  }

}
