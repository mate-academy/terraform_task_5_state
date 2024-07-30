provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "task_5_ah"
    storage_account_name = "storagetask5account"
    container_name       = "task5container"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "task_5_ah" {
  name     = "task_5_ah"
  location = "East US"
}

resource "azurerm_storage_account" "task_5_sa" {
  name                     = "storagetask5account"
  resource_group_name      = azurerm_resource_group.task_5_ah.name
  location                 = azurerm_resource_group.task_5_ah.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "task_5_container" {
  name                  = "task5container"
  storage_account_name  = azurerm_storage_account.task_5_sa.name
  container_access_type = "private"
}

output "resource_group_name" {
  value = azurerm_resource_group.task_5_ah.name
}