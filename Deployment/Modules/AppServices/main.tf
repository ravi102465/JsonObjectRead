resource "azurerm_app_service_plan" "front_app_service_plan" {
  name                = "${var.service_name}-${var.env_name}-front-asp"
  location            = var.location
  resource_group_name = var.resource_group_name
  
  sku {
	tier = "PremiumV2"
	size = "P1v2"
  }
  tags                = var.tags
}

resource "azurerm_app_service" "front_webapp" {
  name                = "${var.service_name}-${var.env_name}-front-webapp"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.front_app_service_plan.id
  tags                = var.tags

  site_config {
    windows_fx_version  =   "DOTNETCORE|3.1"
    ip_restriction {
      virtual_network_subnet_id = var.appgateway_subnet_id
    }
    always_on  = true
    ftps_state = "Disabled"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "front_webapp_vnet_integration" {
  app_service_id = azurerm_app_service.front_webapp.id
  subnet_id      = var.front_end_subnet_id
}

resource "azurerm_app_service_plan" "apptier_app_service_plan" {
  name                = "${var.service_name}-${var.env_name}-app-asp"
  location            = var.location
  resource_group_name = var.resource_group_name
  
  sku {
	tier = "PremiumV2"
	size = "P1v2"
  }
  tags                = var.tags
}

resource "azurerm_app_service" "apptier_webapp" {
  name                = "${var.service_name}-${var.env_name}-app-webapp"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.apptier_app_service_plan.id
  tags                = var.tags

  site_config {
    windows_fx_version  =   "DOTNETCORE|3.1"
    
    ip_restriction {
      virtual_network_subnet_id = var.front_end_subnet_id
    }

    always_on  = true
    ftps_state = "Disabled"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "apptier_webapp_vnet_integration" {
  app_service_id = azurerm_app_service.apptier_webapp.id
  subnet_id      = var.application_subnet_id
}


