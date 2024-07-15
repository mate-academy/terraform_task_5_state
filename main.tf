terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "task5yaasstorage"
    container_name       = "task-5-content"
    key                  = "terraform.tfstate"
    resource_group_name  = "task-5-rg"
  }
}

resource "azurerm_resource_group" "task-5-rg" {
  name     = var.resource_group_name
  location = var.location_for_rg
}

resource "azurerm_storage_account" "task-5-storage-account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.task-5-rg.name
  location                 = azurerm_resource_group.task-5-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "task-5-container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.task-5-storage-account.name
  container_access_type = "private"
}

