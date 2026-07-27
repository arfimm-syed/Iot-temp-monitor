variable "project_id" {
  type = string
}

variable "secrets" {

  type = map(object({

    secret_id = string

    labels = optional(map(string), {})

  }))

}