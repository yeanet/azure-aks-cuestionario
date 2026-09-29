output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.aks.name
}

output "aks_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_fqdn" {
  description = "AKS API server FQDN"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "acr_name" {
  description = "Azure Container Registry name"
  value       = azurerm_container_registry.aks.name
}

output "acr_login_server" {
  description = "ACR login server"
  value       = azurerm_container_registry.aks.login_server
}
