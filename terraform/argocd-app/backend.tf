terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraformState"
    storage_account_name = "stterraformlab10694"
    container_name       = "tfstate"
    key                  = "azure-aks-cuestionario-argocd-app.tfstate"
  }
}