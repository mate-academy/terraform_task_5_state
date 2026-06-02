terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.75.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "myuniquesan2345"
    resource_group_name  = "tfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  use_oidc = true
  features {

  }
}


resource "azurerm_resource_group" "test_rg" {
  name     = "test_rg"
  location = "East US"
}