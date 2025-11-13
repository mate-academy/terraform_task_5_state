terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }

  backend "azurerm" {
    use_oidc             = true
    storage_account_name = "yuriikeniustorageaccount"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    resource_group_name  = "tfstate"
  }
}

provider "azurerm" {
  use_oidc = true
}
