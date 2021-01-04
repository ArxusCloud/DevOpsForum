provider "azurerm" {
  version = "=2.41.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devopsforum-tf"
    storage_account_name = "sadevopsforumtf"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "rg-devopsforum" {
  name     = "rg-devopsforum"
  location = "westeurope"
}