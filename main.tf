terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "prydolobba"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

    use_oidc = true
  }
}

provider "azurerm" {
  features {}

  use_oidc = true
}