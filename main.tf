terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.34.0"
    }
  }
  backend "azurerm" {
    key                  = "terraform.tfstate"
    resource_group_name  = "tfstate"
    storage_account_name = "valodya23"
    container_name       = "tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "example-rg1"
  location = "Poland Central"
}