variable "project_id" {
  type = string
}

variable "storage_buckets" {

  description = "Cloud Storage Buckets"

  type = map(object({

    name                        = string
    location                    = string
    storage_class               = string
    uniform_bucket_level_access = bool
    versioning                  = bool
    force_destroy               = bool

    labels = optional(map(string), {})

    lifecycle_rules = optional(list(object({

      age = number

      action = string

    })), [])

  }))

}