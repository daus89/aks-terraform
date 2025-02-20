
# 🚀 Create Separate Resource Group for Each Environment
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# 🚀 Networking Module (VNet, Subnets)
module "networking" {
  source              = "./modules/networking"
  vnet_name           = var.vnet_name
  resource_group_name = module.resource_group.rg_name
  address_space       = var.address_space
  public_subnet_cidr  = var.subnet_public_cidr
  private_subnet_cidr = var.subnet_private_cidr
  location            = var.location
}

# 🚀 Deploy AKS Cluster in the Private Subnet
module "aks" {
  source              = "./modules/aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  environment         = var.environment
  subnet_id           = module.networking.private_subnet_id
  service_cidr        = var.service_cidr
  dns_service_ip      = var.dns_service_ip 
}

# 🚀 Load Balancer for External Access
module "load_balancer" {
  source              = "./modules/load_balancer"
  resource_group_name = module.resource_group.rg_name
  location           = var.location
  environment        = var.environment
}

# 🚀 Deploy Kubernetes Resources (Nginx, Service, Namespace)
module "k8s" {
  source      = "./modules/k8s"
  environment = var.environment
}

# 🚀 Outputs
output "dev_load_balancer_ip" {
  value = module.k8s.lb_ip
}