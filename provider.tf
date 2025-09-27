terraform {
  required_version = ">= 1.8.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.105.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate" # Замінити на реальне ім'я
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}