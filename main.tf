terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }

  backend "azurerm" {
    use_oidc             = true
    resource_group_name  = "tfstate"
    storage_account_name = "tfstsacc"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "azurerm" {

  use_oidc = true

  features {}
}