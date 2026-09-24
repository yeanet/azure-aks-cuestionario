#variable "subscription_id" {
#  description = "Azure Subscription ID"
#  type        = string
#}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Sweden Central"
}

variable "resource_group_name" {
  description = "Resource Group for AKS infrastructure"
  type        = string
  default     = "rg-aks-cuestionario"
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
  default     = "aks-cuestionario"
}

variable "acr_name" {
  description = "Azure Container Registry name. Must be globally unique."
  type        = string
  default     = "acrcuestionario10694"
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "aks_subnet_address_prefix" {
  description = "AKS subnet address prefix"
  type        = string
  default     = "10.20.1.0/24"
}
