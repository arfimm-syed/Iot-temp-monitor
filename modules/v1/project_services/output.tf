output "enabled_services" {


  description = "Enabled Google APIs"


  value = {

    for key, service in google_project_service.services :

    key => service.service

  }

}