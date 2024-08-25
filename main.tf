provider "azurerm" {
  features {}
  use_oidc = true
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "mate5cube"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

