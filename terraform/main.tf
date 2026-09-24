resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "aks" {
  name                = "vnet-aks-cuestionario"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name

  address_space = var.vnet_address_space
}

resource "azurerm_subnet" "aks" {
  name                 = "subnet-aks"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name

  address_prefixes = [var.aks_subnet_address_prefix]
}

resource "azurerm_container_registry" "aks" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks.name
  location            = azurerm_resource_group.aks.location

  sku           = "Basic"
  admin_enabled = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name

  dns_prefix = "aks-cuestionario"

  default_node_pool {
    name           = "system"
    vm_size        = "Standard_B2s_v2"
    node_count     = 1
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    project     = "cuestionario"
    environment = "lab"
    managed_by  = "terraform"
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.aks.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
