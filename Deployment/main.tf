resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name_prefix}-${local.env_name}-rg"
  location = var.location
  tags     = local.tags
}

module "vnet" {
source                           = "./Modules/Vnet"
  name                             = "${local.service_name}-${local.env_name}-vnet"
  location                         = azurerm_resource_group.rg.location
  resource_group_name              = azurerm_resource_group.rg.name
  tags                             = local.tags
}

module "azure_sql" {
  source                           = "./Modules/AzureSql"
  name                             = "${local.service_name}-${local.env_name}-sqlserver"
  database_name                    = "${local.service_name}-${local.env_name}-db"
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = azurerm_resource_group.rg.location
  sql_administrator_login          = var.sql_administrator_login
  sql_administrator_login_password = var.sql_administrator_login_password
  tags                             = local.tags
  env_name                         = local.env_name
  subnet_id                         = module.vnet.db_subnet_id
}

module "app_service" {
  source              = "./Modules/AppServices"
  service_name		  = local.service_name
  env_name			  = local.env_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  front_end_subnet_id   = module.vnet.front_end_subnet_id
  application_subnet_id	= module.vnet.app_subnet_id
  appgateway_subnet_id	= module.vnet.appgateway_subnet_id
  tags = local.tags

}
