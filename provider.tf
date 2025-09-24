terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  # Віддалений бекенд в Azure Storage
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "<unique-storage-account-name>" # Замінити на реальне ім'я
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true  # Увімкнути OIDC автентифікацію
  }
}

provider "azurerm" {
  features {}
  use_oidc = true  # Увімкнути OIDC для провайдера
}