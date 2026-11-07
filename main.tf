terraform {
  backend "azurerm" {
    use_oidc             = true
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatefilesmate"
    container_name       = "tfstate"
    key                  = "test.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.13.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
