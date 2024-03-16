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
    ip_rules                   = ["189.111.15.196/30"]
  }
  identity {
    identity_ids = [ "3c2ddc3b-307b-44b2-aa99-d57055238d1e" ]
    type = "UserAssigned"
  }
  }

output "st_name" {
  value = azurerm_storage_account.storage_account.name
}
resource "azurerm_storage_container" "storage_container" {
  name                  = var.asc_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access_type
}

