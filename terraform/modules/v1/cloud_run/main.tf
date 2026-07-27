resource "google_cloud_run_v2_service" "service" {

  for_each = var.cloud_run_services

  project = var.project_id
  location = var.region
  name = each.value.name
  ingress = each.value.ingress

  labels = each.value.labels

  template {

    service_account = each.value.service_account

    timeout = "${each.value.timeout}s"

    scaling {

      min_instance_count = each.value.min_instances
      max_instance_count = each.value.max_instances

    }

    containers {

      image = each.value.image

      ports {

        container_port = each.value.port

      }

      resources {

        limits = {

          cpu = each.value.cpu
          memory = each.value.memory

        }

      }

      dynamic "env" {

        for_each = each.value.env

        content {

          name = env.key
          value = env.value

        }

      }

      dynamic "env" {

        for_each = each.value.secrets

        iterator = secret

        content {

          name = secret.key

          value_source {

            secret_key_ref {

              secret = secret.value.secret

              version = secret.value.version

            }

          }

        }

      }

    }

  }

}

resource "google_cloud_run_service_iam_member" "invoker" {

  for_each = {

    for k,v in var.cloud_run_services :

    k => v

    if v.allow_unauthenticated

  }

  project = var.project_id

  location = var.region

  service = google_cloud_run_v2_service.service[each.key].name

  role = "roles/run.invoker"

  member = "allUsers"

}