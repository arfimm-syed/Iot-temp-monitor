resource "google_artifact_registry_repository" "repositories" {

  for_each = var.repositories

  project = var.project_id

  location = each.value.location

  repository_id = each.value.repository_id

  format = upper(each.value.format)

  description = try(each.value.description, null)

  labels = each.value.labels

  docker_config {

    immutable_tags = each.value.immutable_tags

  }

}