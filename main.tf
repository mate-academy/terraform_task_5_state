terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatec832f1722fc4496c"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }
}

provider "azurerm" {
  features {}

  use_oidc                   = true
  skip_provider_registration = true
}

resource "terraform_data" "example" {
  input = "terraform-task-5"
}

data "azurerm_resource_group" "state" {
  name = "tfstate"
}

output "state_resource_group" {
  description = "Resource group that contains the state storage account."
  value       = data.azurerm_resource_group.state.name
}
