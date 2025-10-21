terraform {
  required_version = ">= 1.8.4"

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = var.storage_account_name
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

variable "storage_account_name" {
  type        = string
  description = "Name of the existing Azure Storage Account for Terraform state"
}
