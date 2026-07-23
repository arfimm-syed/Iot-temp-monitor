resource "google_project_service" "services" {


  for_each = var.services


  project = var.project_id


  service = each.value.service


  disable_on_destroy = each.value.disable_on_destroy


}