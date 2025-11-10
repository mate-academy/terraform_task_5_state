terraform {
  required_version = ">= 1.8.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.52.0"
    }
  }

  # Remote state у Azure Blob з OIDC
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatevitaliy123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

# Провайдер під OIDC (без client secret)
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  use_oidc        = true
}

# Змінна, щоб отримати id підписки з секретів / env
variable "subscription_id" {
  type        = string
  description = "Azure subscription ID used by the provider."
}
