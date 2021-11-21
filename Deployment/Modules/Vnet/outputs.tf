output "front_end_subnet_id" {
  value       = azurerm_subnet.front_subnet.id
}

output "app_subnet_id" {
    value       = azurerm_subnet.app_subnet.id
}

output "db_subnet_id" {
  value       = azurerm_subnet.db_subnet.id
}