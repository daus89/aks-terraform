
# 🚀 Create Separate Resource Group for Each Environment
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# 🚀 Networking Module (VNet, Subnets)
module "networking" {
  source              = "./modules/networking"
  resource_group_name = module.resource_group.rg_name
  vnet_cidr           = var.vnet_cidr
  subnet_public_cidr  = var.subnet_public_cidr
  subnet_private_cidr = var.subnet_private_cidr
}

# 🚀 Deploy AKS Cluster in the Private Subnet
module "aks" {
  source              = "./modules/aks"
}

# 🚀 Load Balancer for External Access
module "load_balancer" {
  source              = "./modules/load_balancer"
  resource_group_name = module.resource_group.rg_name
  location           = var.location
}

# 🚀 Deploy Kubernetes Resources (Nginx, Service, Namespace)
module "k8s" {
  source      = "./modules/k8s"
  environment = var.environment
}

# 🚀 Outputs
output "dev_load_balancer_ip" {
  value = module.kubernetes.lb_ip
}