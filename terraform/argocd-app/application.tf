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
}