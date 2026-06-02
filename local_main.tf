# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "4.75.0"
#     }
#   }
# }

# provider "azurerm" {
#   features {

#   }
# }



# resource "azurerm_resource_group" "name" {
#   name     = "tfstate"
#   location = "East US"
# }

# resource "azurerm_storage_account" "name" {
#   name                     = "myuniquesan2345"
#   location                 = azurerm_resource_group.name.location
#   resource_group_name      = azurerm_resource_group.name.name
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# resource "azurerm_storage_container" "name" {
#   storage_account_id = azurerm_storage_account.name.id
#   name               = "tfstate"
# }