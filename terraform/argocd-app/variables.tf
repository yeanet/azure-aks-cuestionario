variable "resource_group_name" {
  description = "Resource Group containing AKS"
  type        = string
  default     = "rg-aks-cuestionario"
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
  default     = "aks-cuestionario"
}

variable "argocd_repo_password" {
  description = "PAT de Azure DevOps utilizado por Argo CD para acceder al repositorio Git"
  type        = string
  sensitive   = true
}