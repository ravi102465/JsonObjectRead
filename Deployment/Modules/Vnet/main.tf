resource "azurerm_virtual_network" "vent" {
  name                = var.name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "front_subnet" {
  name                 = "front-subnet"
  resource_group_name  = var.name
  virtual_network_name = azurerm_virtual_network.vent.name
  address_prefixes     = ["10.0.1.0/24"]
  }

  resource "azurerm_subnet" "app_subnet" {
  name                 = "app-subnet"
  resource_group_name  = var.name
  virtual_network_name = azurerm_virtual_network.vent.name
  address_prefixes     = ["10.0.2.0/24"]
  }

  resource "azurerm_subnet" "db_subnet" {
  name                 = "db-subnet"
  resource_group_name  = var.name
  virtual_network_name = azurerm_virtual_network.vent.name
  address_prefixes     = ["10.0.3.0/24"]
  }

resource "azurerm_subnet" "appgateway_subnet" {
  name                 = "db-subnet"
  resource_group_name  = var.name
  virtual_network_name = azurerm_virtual_network.vent.name
  address_prefixes     = ["10.0.4.0/24"]
  }
}