variable "project_id" {
  description = "GCP project ID"
  type        = string
}


variable "services" {

  description = "List of Google APIs to enable"

  type = map(object({

    service = string

    disable_on_destroy = optional(bool, false)

  }))

}