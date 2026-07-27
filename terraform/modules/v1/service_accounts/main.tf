resource "google_service_account" "service_accounts" {

  for_each = var.service_accounts

  project = var.project_id

  account_id   = each.value.account_id
  display_name = each.value.display_name
  description  = each.value.description
  disabled     = each.value.disabled

}