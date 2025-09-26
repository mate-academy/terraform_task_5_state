terraform {
  required_version = ">= 1.8.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"

    }
  }

  backend "azurerm" {
    use_oidc             = true
    resource_group_name  = "tfstate"
    storage_account_name = "electricwizard3456263"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

}


provider "azurerm" {
  features {}
}

