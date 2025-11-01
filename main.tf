terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "myaccounttfstate111"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    resource_group_name  = "tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
    features {}

    use_oidc             = true
}



