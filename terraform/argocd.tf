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

resource "kubernetes_manifest" "cuestionario_application" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "cuestionario"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      source = {
        repoURL        = "https://github.com/yeanet/Cuestionario.git"
        targetRevision = "main"
        path           = "helm/cuestionario"
      }

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "cuestionario"
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }

        syncOptions = [
          "CreateNamespace=true"
        ]
      }
    }
  }

  depends_on = [
    helm_release.argocd
  ]
}