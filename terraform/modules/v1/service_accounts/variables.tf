variable "project_id" {
  description = "GCP Project ID"
  type        = string

  validation {
    condition     = length(var.project_id) > 5
    error_message = "Project ID must be valid."
  }
}

variable "service_accounts" {

  description = "Service Accounts"

  type = map(object({

    account_id   = string
    display_name = string
    description  = string

    disabled = optional(bool, false)

    labels = optional(map(string), {})

  }))

  validation {

    condition = alltrue([
      for sa in values(var.service_accounts) :
      length(sa.account_id) >= 6
    ])

    error_message = "Account IDs must contain at least 6 characters."
  }

}