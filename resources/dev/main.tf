provider "azurerm" {
  features {}
}

locals {
  tags = {
    environment       = "dev"
    project_name      = "challenge"
    critical          = "no"
  }
  location     = "us-central"
  rg_name      = "rg-challenge-dev"
  project_name = "challenge-dev"
}   

module "rg-challenge-dev" {
  source    = "../../modules/rg"
  rg_name   = local.rg_name
  location  = local.location
}

module "cr-challenge-dev" {
source              = "../../modules/cr"
location            = local.location
rg_name             = "rg-challenge-dev"
cr_name             = "cr-challange-dev"
sku                 = "Basic"
admin_enabled       = true
environment         = local.tags.environment
project_name        = local.tags.project_name
critical            = local.tags.critical

}

module "nsg-challange" {
  source              = "../../modules/nsg"
  nsg_name            = "nsg-challenge-dev"
  location            = local.location 
  rg_name             = local.rg_name
  project_name        = local.project_name
  subnet_id           = module.subnet-challenge-dev.subnet_id
  environment         = local.tags.environment
  critical            = local.tags.critical

}

module "storage_account-challenge-dev" {
  source = "../../modules/st"
  location                 = local.location 
  rg_name                  = local.rg_name
  project_name             = local.project_name
  environment              = local.tags.environment
  critical                 = local.tags.critical
  account_tier             = "Standard"
  st_name                  = "account-storage-challenge-dev"
  container_access_type    = "private"
  account_replication_type = "GRS"
  account_kind             = "Storage"
  asc_name                 = "account-storage-challenge-dev"
}

module "vnet" {
  source        = "../../modules/vnet"
  location      = local.location
  environment   = local.tags.environment
  address_space = ["10.0.0.0/16"]
  vnet_name     = "vnet-challenge-dev"
  project_name  = local.project_name
  critical      = local.tags.critical
  rg_name       = local.rg_name
}

module "subnet-challenge-dev" {
  source               = "../../modules/subnet"
  rg_name              = local.rg_name
  virtual_network_name = "vnet-challenge-dev"
  address_prefixes     = ["10.0.1.0/24"]
  subnet_name          = "subnet-challenge-dev"
}

module "aks" {
  source = "../../modules/aks"
  node_pool_enable_auto_scaling           = true
  default_node_pool_enable_node_public_ip = true
  default_node_pool_min_count             = "1"
  default_node_pool_vnet_subnet_id        = module.subnet-challenge-dev.subnet_id
  project_name                            = local.project_name
  critical                                = local.tags.critical
  rg_name                                 = local.rg_name
  k8s_version                             = "1.29"
  aks_name                                = "aks-challenge-dev"
  default_node_pool_vm_size               = "Standard B1s"
  default_node_pool_max_pods              = "4"
  location                                = local.location
  default_node_pool_os_disk_size_gb       = "50"
  environment                             = local.tags.environment
  default_node_pool_node_count            = "1"
  default_node_pool_name                  = "nodepool-aks-challenge"
  node_pool_vnet_subnet_id                = module.subnet-challenge-dev.subnet_id
  default_node_pool_max_count             = "1"
  node_pool_name                          = "nodepool-aks-challenge"
  node_pool_os_disk_size_gb               = "50"
  node_pool_vm_size                       = "Standard B1s"
  node_pool_max_count                     = "1"
  node_pool_min_count                     = "1"
 node_pool_enable_node_public_ip          = true
 node_pool_max_pods                       = "4"
 default_node_pool_enable_auto_scaling    = true
 node_pool_node_count                     = "1"
 dns_prefix = "aks-challenge-dev"
}
