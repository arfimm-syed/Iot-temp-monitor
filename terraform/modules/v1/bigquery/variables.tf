variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "bigquery" {

  description = "BigQuery configuration"

  type = map(object({

    dataset_id = string

    location = string

    delete_contents_on_destroy = optional(bool, false)

    labels = optional(map(string), {})

    default_table_expiration_ms = optional(number)

    tables = map(object({

      table_id = string

      schema_file = string

      deletion_protection = optional(bool, false)

      time_partitioning = optional(object({

        type = string

        field = optional(string)

      }))

      clustering = optional(list(string), [])

    }))

  }))

}

