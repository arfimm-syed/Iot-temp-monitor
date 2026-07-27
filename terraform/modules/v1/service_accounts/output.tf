output "service_accounts" {

  description = "Created Service Accounts"

  value = {

    for k, sa in google_service_account.service_accounts :

    k => {

      email = sa.email

      name = sa.name

      unique_id = sa.unique_id

    }

  }

}