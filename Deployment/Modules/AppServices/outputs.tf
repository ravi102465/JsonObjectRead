output "front_end_default_site_hostname" {
  value = azurerm_app_service.front_webapp.default_site_hostname
}

output "apptier_webapp" {
  value = azurerm_app_service.apptier_webapp.default_site_hostname
}