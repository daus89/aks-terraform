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

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_public_cidr" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
}

variable "subnet_private_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
}

variable "subnet_private_dns_zone_name" {
  type    = string
  default = "my-private-dns-zone"  # Change this value as needed
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}