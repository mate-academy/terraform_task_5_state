terraform {
  required_version = ">= 1.8.4"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "azurerm" {
    # storage_account_name is hard-coded because Terraform backend
    # does not support variables.
    storage_account_name = "boomtfstatestorage"
    container_name       = "tfstate"
    resource_group_name  = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}