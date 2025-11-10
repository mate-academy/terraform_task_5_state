terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatevitaliy123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.52.0"
    }
  }
}
