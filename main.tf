# Step 1: initialize with local backend
# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }
# Step 2: migrate to remote azurerm backend using:
# terraform init -migrate-state
terraform {
  required_version = ">= 1.8.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.41.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "matetfstatestorageac52"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}