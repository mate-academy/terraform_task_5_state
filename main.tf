# main.tf (Фінальна конфігурація з Azurerm Remote Backend)

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "azurerm" {
    # Цей блок вказує, що стан буде зберігатися в Azure Blob Storage
    resource_group_name  = "tfstate"
    storage_account_name = "langrafkastore" # ВАШЕ УНІКАЛЬНЕ ІМ'Я!
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    use_oidc             = true # УВІМКНЕНО OIDC ДЛЯ BACKEND
  }
}

provider "azurerm" {
  features {}
  # Згідно завдання: use_oidc = true для використання у CI/CD
  use_oidc = true # УВІМКНЕНО OIDC ДЛЯ ПРОВАЙДЕРА
}

resource "azurerm_resource_group" "state_test" {
  name     = "state-migration-test-rg"
  location = "eastus"
  tags = {
    Task = "5"
  }
}