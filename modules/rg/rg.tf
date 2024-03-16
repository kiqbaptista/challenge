resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
  managed_by = var.managed_by
}
output "rg_name" {
  value = azurerm_resource_group.rg.name
}