output "repository_ids" {

  value = {

    for k, v in google_artifact_registry_repository.repositories :

    k => v.id

  }

}

output "repository_names" {

  value = {

    for k, v in google_artifact_registry_repository.repositories :

    k => v.name

  }

}

output "repository_urls" {

  value = {

    for k, v in google_artifact_registry_repository.repositories :

    k => "${v.location}-docker.pkg.dev/${var.project_id}/${v.repository_id}"

  }

}

