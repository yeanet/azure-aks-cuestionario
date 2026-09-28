resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "10.9.2"

  wait    = true
  timeout = 900

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}