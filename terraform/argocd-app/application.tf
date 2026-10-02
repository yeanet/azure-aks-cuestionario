resource "kubernetes_secret" "argocd_azuredevops_repo" {
  metadata {
    name      = "azuredevops-repo"
    namespace = "argocd"

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  type = "Opaque"

  string_data = {
    type     = "git"
    url      = "https://dev.azure.com/yeanet-devops/Cuestionario-AzureDevOps/_git/Cuestionario-AzureDevOps"
    username = "yeanet-devops"
    password = var.argocd_repo_password
  }

  depends_on = [
    helm_release.argocd
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
        repoURL        = "https://dev.azure.com/yeanet-devops/Cuestionario-AzureDevOps/_git/Cuestionario-AzureDevOps"
        targetRevision = "master"
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
    kubernetes_secret.argocd_azuredevops_repo
  ]
}