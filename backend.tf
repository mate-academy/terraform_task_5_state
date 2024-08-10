terraform {
  backend "azurerm" {
    storage_account_name = "tfstatemateyegor"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    resource_group_name  = "tfstate"
    use_oidc             = true
  }
}
