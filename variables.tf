variable "environment" {
  description = "Deployment environment (dev, qa, prod)"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "vnet_cidr" {
  description = "VNet CIDR block"
  type        = string
}

variable "subnet_public_cidr" {
  description = "Public subnet CIDR block"
  type        = string
}

variable "subnet_private_cidr" {
  description = "Private subnet CIDR block"
  type        = string
}