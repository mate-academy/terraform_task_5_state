terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "tfstorage11"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    resource_group_name  = "tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}