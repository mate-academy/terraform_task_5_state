terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "levandriitfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    resource_group_name  = "tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


