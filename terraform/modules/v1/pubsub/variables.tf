variable "project_id" {
  type = string
}

variable "pubsub" {

  description = "Pub/Sub configuration"

  type = map(object({

    topic_name = string

    labels = optional(map(string), {})

    subscriptions = map(object({

      name = string

      ack_deadline_seconds = optional(number, 30)

      message_retention_duration = optional(string, "604800s")

      enable_message_ordering = optional(bool, false)

      retry_policy = optional(object({
        minimum_backoff = string
        maximum_backoff = string
      }))

      dead_letter = optional(object({

        enabled = bool

        topic_name = string

        max_delivery_attempt = number

      }))

    }))

  }))

  validation {

    condition = alltrue([
      for topic in values(var.pubsub) :
      length(topic.topic_name) > 3
    ])

    error_message = "Topic name must be at least 4 characters."

  }

}

