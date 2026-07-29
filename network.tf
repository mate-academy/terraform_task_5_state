resource "azurerm_virtual_network" "example" {
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
}
