terraform {
  required_version = ">= 1.8.4"

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstateaccount2024"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
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

# Простий тестовий ресурс
resource "azurerm_resource_group" "example" {
  name     = "rg-terraform-test"
  location = "East US"
}