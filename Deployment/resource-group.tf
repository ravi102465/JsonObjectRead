resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name_prefix}-${local.env_name}-rg"
  location = var.location
  tags     = local.tags
}