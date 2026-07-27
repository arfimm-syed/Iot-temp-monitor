variable "project_id" {
  type = string
}

variable "repositories" {

  description = "Artifact Registry repositories"

  type = map(object({

    repository_id = string

    location = string

    format = string

    description = optional(string)

    labels = optional(map(string), {})

    immutable_tags = optional(bool, false)

  }))

  validation {

    condition = alltrue([
      for repo in values(var.repositories) :
      contains(
        ["DOCKER", "MAVEN", "NPM", "PYTHON", "GO", "APT", "YUM"],
        upper(repo.format)
      )
    ])

    error_message = "Repository format is invalid."

  }

}