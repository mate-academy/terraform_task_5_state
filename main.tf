terraform {
  backend "azurerm" {
    storage_account_name = "alexdev"
    container_name       = "tfstate"
    key                  = "task5.terraform.tfstate"
    resource_group_name  = "tfstate"

    use_oidc = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.4.0"
    }
  }
}

provider "azurerm" {
  features {}

  use_oidc = true
}