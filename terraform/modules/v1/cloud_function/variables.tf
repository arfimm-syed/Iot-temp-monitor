variable "functions" {

  type = map(object({

    name = string

    runtime = string

    entry_point = string

    bucket = string

    object = string

    service_account = string

    memory = string

    timeout = number

    max_instances = number

    env = map(string)

    pubsub_topic = string

  }))

}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}