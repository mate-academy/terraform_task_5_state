terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "kukuruki4"
    container_name       = "tfstate"
    key                  = "prod.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
