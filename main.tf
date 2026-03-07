terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.63.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "tfstate"
    storage_account_name  = "tfstatematetask"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
    use_oidc = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFStateResourceGroup"
  location = "East US"
}
