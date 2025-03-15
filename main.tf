terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "matestorage1234"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
    subscription_id       = "63322e75-611d-4ff5-9a33-1f266fff00ee"
  }
}


provider "azurerm" {
  features {}
}