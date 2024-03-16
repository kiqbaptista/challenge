resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space

  tags = {
      environment  = local.tags.environment
      project_name = local.tags.project_name
      critical     = local.tags.critical
  }
}

locals {
  tags = {
    environment       = "dev"
    project_name      = "challenge-dev"
    critical          = var.critical
  }
} 
