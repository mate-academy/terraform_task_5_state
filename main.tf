terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.110.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "ikmyTFStateResourceGroup"
    storage_account_name = "ikmytfstatestorage"
    container_name       = "iktfstate"
    key                  = "/.terraform/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "ikmyTFStateResourceGroup"
  location = "East US"
}

resource "azurerm_storage_account" "sa" {
  name                     = "ikmytfstatestorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc" {
  name                  = "iktfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
