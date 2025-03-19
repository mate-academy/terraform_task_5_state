terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "task5zz9854ug93fo4"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    resource_group_name  = "tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
}