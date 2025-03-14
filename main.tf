terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "task5tfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
