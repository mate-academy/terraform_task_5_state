terraform {
  required_version = ">= 1.8.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "amajlotfstate5"
    container_name       = "tfstate"
    key                  = "terraform-task-5.tfstate"
    use_oidc             = true
    use_azuread_auth     = true
  }
}
