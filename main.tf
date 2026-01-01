terraform {
  required_version = ">= 1.8.4"

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatemaxim01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

    use_oidc = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
