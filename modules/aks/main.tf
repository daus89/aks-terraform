
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.environment}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.environment}-aks"
  
  network_profile {
    network_plugin = "azure"
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip 
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
}

