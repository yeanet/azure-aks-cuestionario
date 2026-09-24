terraform {
  backend "azurerm" {
    use_oidc         = true
    use_azuread_auth = true

    resource_group_name  = "rg-terraformState"
    storage_account_name = "stterraformlab10694"
    container_name       = "tfstate"
    key                  = "azure-aks-cuestionario.tfstate"

  }
}
