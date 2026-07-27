variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "cloud_run_services" {

  type = map(object({

    name = string

    ingress = string

    service_account = string

    image = string

    port = number

    cpu = string

    memory = string

    timeout = number

    min_instances = number

    max_instances = number

    allow_unauthenticated = bool

    labels = map(string)

    env = map(string)

    secrets = optional(map(object({
      secret = string
      version = string
    })), {})

  }))

}
