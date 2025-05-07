terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.25.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "storagemate34"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    resource_group_name  = "tfstate"
    use_oidc             = true
  }
}


provider "azurerm" {
  features {}
}