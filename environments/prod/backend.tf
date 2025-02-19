# For remote backend tf state
# terraform {
#  backend "azurerm" {
#    resource_group_name  = "terraform-state-rg"
#    storage_account_name = "terraformstate"
#    container_name       = "tfstate"
#    key                  = "terraform.tfstate"
#  }
# }


# For locally store tf state
terraform {
    backend "local" {
    path = "./environments/prod/terraform.tfstate"
  }
}

