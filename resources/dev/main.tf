locals {
  tags = {
    environment       = "dev"
    project_name      = "challenge"
    critical          = "no"
  }
  location     = ""
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
sku                 = ""
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
  vpn_ip              = ""
  subnet_id           = "" 
  environment         = local.tags.environment
  critical            = local.tags.critical
}

module "storage_account-challenge-dev" {
  source = "../../modules/st"
  location            = local.location 
  rg_name             = local.rg_name
  project_name        = local.project_name
  vpn_ip              = ""
  environment         = local.tags.environment
  critical            = local.tags.critical
  tags = locals.tags
  account_tier = ""
  st_name = "storage-account-challenge-dev"
  container_access_type = ""
  account_replication_type = ""
  account_kind = ""
  asc_name = ""
}

module "vnet" {
  source = "../../modules/vnet"
  location = local.location
  environment = local.tags.environment
  address_space = ""
  vnet_name = "vnet-challenge-dev"
  project_name = local.project_name
  critical = local.tags.critical
  rg_name = local.rg_name
  tags = locals.tags
}

module "subnet-challenge-dev" {
  source = "../../modules/subnet"
  rg_name = local.rg_name
  virtual_network_name = "vnet-challenge-dev"
  address_prefixes = ""
  subnet_name = "subnet-challenge-dev"
}

module "aks" {
  source = "../../modules/aks"
  node_pool_enable_auto_scaling           = ""
  node_pool_enable_node_public_ip         = ""
  node_pool_max_count                     = ""
  default_node_pool_enable_auto_scaling   = ""
  node_pool_max_pods                      = ""
  default_node_pool_enable_node_public_ip = ""
  default_node_pool_min_count             = ""
  node_pool_node_count                    = ""
  node_pool_os_disk_size_gb               = ""
  default_node_pool_vnet_subnet_id        = ""
  project_name                            = local.project_name
  critical                                = local.tags.critical
  rg_name                                 = local.rg_name
  k8s_version                             = ""
  aks_name                                = ""
  default_node_pool_vm_size               = ""
  dns_prefix                              = ""
  default_node_pool_max_pods              = ""
  location                                = local.location
  node_pool_min_count                     = ""
  default_node_pool_os_disk_size_gb       = ""
  environment                             = local.tags.environment
  default_node_pool_node_count            = ""
  default_node_pool_name                  = ""
  node_pool_vnet_subnet_id                = ""
  default_node_pool_max_count             = ""
  node_pool_name                          = ""
  node_pool_vm_size                       = ""

}
