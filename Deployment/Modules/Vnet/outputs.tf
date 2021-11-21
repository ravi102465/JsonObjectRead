output "front_end_subnet_id" {
  value       = azurerm_subnet.front_subnet.id
}

output "app_subnet_id" {
    value       = azurerm_subnet.app_subnet.id
}

output "db_subnet_id" {
  value       = azurerm_subnet.db_subnet.id
}

output "appgateway_subnet_id" {
  value       = azurerm_subnet.appgateway_subnet.id
}

output "appgateway_vnet_name" {
  value       = azurerm_virtual_network.vnet.name
}