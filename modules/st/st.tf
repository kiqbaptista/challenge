resource "azurerm_storage_account" "storage_account" {
  name                     = var.st_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = []
    ip_rules                   = var.vpn_ip
  }

  tags = {
      environment  = local.tags.environment
      project_name = local.tags.project_name
      critical     = local.tags.critical


  }
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.asc_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access_type
}

locals {
  tags = {
    environment       = var.environment
    project_name      = var.project_name
    critical          = var.critical
  }
} 
