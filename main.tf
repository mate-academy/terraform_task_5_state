terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "kagerou4649secondstorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
