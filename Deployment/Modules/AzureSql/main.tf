resource "azurerm_sql_server" "sqlserver" {
  name                         = lower(var.name)
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_administrator_login
  administrator_login_password = var.sql_administrator_login_password
  tags  =   var.tags

}

resource "azurerm_sql_database" "sqldatabase" {
  name                             = lower(var.database_name)
  resource_group_name              = var.resource_group_name
  location                         = var.location
  server_name                      = azurerm_sql_server.sqlserver.name
  edition                          = "Standard"
  requested_service_objective_name = "S1"

  tags  = var.tags
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  name                = "sql-vnet-rule"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.sqlserver.name
  subnet_id           = var.subnet_id
}