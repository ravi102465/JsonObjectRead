resource "azurerm_public_ip" "public_ip" {
  name                = "${var.service_name}-${var.env_name}-front-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${var.vnet_name}-beap"
  frontend_port_name             = "${var.vnet_name}-feport"
  frontend_ip_configuration_name = "${var.vnet_name}-feip"
  http_setting_name              = "${var.vnet_name}-be-htst"
  listener_name                  = "${var.vnet_name}-httplstn"
  request_routing_rule_name      = "${var.vnet_name}-rqrt"
  redirect_configuration_name    = "${var.vnet_name}-rdrcfg"
  backend_probe_name             = "${var.vnet_name}-probe"
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = "${var.service_name}-${var.env_name}-appgateway"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.gateway_subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 8080
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
    fqdns = var.backend_webapp_fqdn
  }

  probe {
    name                                      = local.backend_probe_name
    protocol                                  = "Https"
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 120
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
    match {
      body        = "Welcome"
      status_code = [200, 399]
    }
  }

  backend_http_settings {
    name                                = local.http_setting_name
    probe_name                          = local.backend_probe_name
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 120
    pick_host_name_from_backend_address = true
  }

  http_listener {
      name                           = local.listener_name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Http"
  }

  request_routing_rule {
      name                       = local.request_routing_rule_name
      rule_type                  = "Basic"
      http_listener_name         = local.listener_name
      backend_address_pool_name  = local.backend_address_pool_name
      backend_http_settings_name = local.http_setting_name
    }
}