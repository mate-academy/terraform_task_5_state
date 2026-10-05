terraform {
  required_version = ">= 1.8.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-eastus"
    storage_account_name = "tfstateeastus2026"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}

  use_oidc = true
}


resource "azurerm_resource_group" "example" {
  name     = "tfstate"
  location = "eastus"
}
