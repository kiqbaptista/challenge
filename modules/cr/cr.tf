resource "azurerm_container_registry" "cr" {
  name                = var.cr_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled


}
