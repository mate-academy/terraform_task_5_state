terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Конфигурация удаленного бэкенда
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "gosxanstorage369"
    container_name       = "tfstate"             # Имя контейнера внутри Storage Account
    key                  = "terraform.tfstate"   # Имя файла стейта в контейнере
    use_oidc             = true                  # Включаем OIDC для бэкенда
  }
}

provider "azurerm" {
  features {}
  use_oidc = true # Включаем OIDC для провайдера
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}