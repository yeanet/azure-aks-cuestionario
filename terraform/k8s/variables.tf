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