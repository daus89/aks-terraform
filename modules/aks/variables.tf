variable "environment" {
    description = "The environment name"
    type        = string
}

variable "location" {
    description = "The location"
    type        = string
}

variable "resource_group_name" {
    description = "The resource group name"
    type        = string
}

variable "subnet_id" {}
variable "service_cidr" {
    description = "The service CIDR"
    type        = string
}
variable "dns_service_ip" {
    description = "The DNS service IP"
    type        = string
}