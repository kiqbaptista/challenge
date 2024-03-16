terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "state-files-challenge-kiq"
      storage_account_name = "storagestatefileskiq"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }

}


provider "azurerm" {
  features {}
}

locals {
  tags = {
    environment       = "prod"
    project_name      = "challenge"
    critical          = "no"
  }
  location     = "brazilsouth"
  rg_name      = "rg-challenge-prod-kiq"
  project_name = "challenge-prod"
}   

module "rg-challenge-prod" {
  source    = "../../modules/rg"
  rg_name   = local.rg_name
  location  = local.location
  managed_by = "3c2ddc3b-307b-44b2-aa99-d57055238d1e"
}

module "cr-challenge-prod" {
source              = "../../modules/cr"
location            = local.location
rg_name             = module.rg-challenge-prod.rg_name
cr_name             = "crchallangeprod"
sku                 = "Basic"
admin_enabled       = true
environment         = local.tags.environment
project_name        = local.tags.project_name
critical            = local.tags.critical

}

module "nsg-challange" {
  source              = "../../modules/nsg"
  nsg_name            = "nsg-challenge-prod"
  location            = local.location 
  rg_name             = module.rg-challenge-prod.rg_name
  project_name        = local.project_name
  subnet_id           = module.subnet-challenge-prod.subnet_id
  environment         = local.tags.environment
  critical            = local.tags.critical

}

module "storage_account-challenge-prod" {
  source = "../../modules/st"
  location                 = local.location 
  rg_name                  = module.rg-challenge-prod.rg_name
  project_name             = local.project_name
  environment              = local.tags.environment
  critical                 = local.tags.critical
  account_tier             = "Standard"
  st_name                  = "aschallengeprod"
  container_access_type    = "private"
  account_replication_type = "GRS"
  account_kind             = "Storage"
  asc_name                 = "account-storage-challenge-prod"
}

module "vnet" {
  source        = "../../modules/vnet"
  location      = local.location
  environment   = local.tags.environment
  address_space = ["10.1.0.0/16"] 
  vnet_name     = "vnet-challenge-prod"
  project_name  = local.project_name
  critical      = local.tags.critical
  rg_name       = module.rg-challenge-prod.rg_name
}

module "subnet-challenge-prod" {
  source               = "../../modules/subnet"
  rg_name              = module.rg-challenge-prod.rg_name
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["10.1.0.0/22"] 
  subnet_name          = "subnet-challenge-prod"
}

module "aks" {
  source = "../../modules/aks"
  node_pool_enable_auto_scaling           = true
  default_node_pool_enable_node_public_ip = true
  default_node_pool_min_count             = "1"
  default_node_pool_vnet_subnet_id        = module.subnet-challenge-prod.subnet_id
  project_name                            = local.project_name
  critical                                = local.tags.critical
  rg_name                                 = module.rg-challenge-prod.rg_name
  k8s_version                             = "1.29"
  aks_name                                = "aks-challenge-prod"
  default_node_pool_vm_size               = "standard_b12ms"
  default_node_pool_max_pods              = "30"
  location                                = local.location
  default_node_pool_os_disk_size_gb       = "50"
  environment                             = local.tags.environment
  default_node_pool_node_count            = "1"
  default_node_pool_name                  = "npchallenge"
  node_pool_vnet_subnet_id                = module.subnet-challenge-prod.subnet_id
  default_node_pool_max_count             = "1"
  node_pool_name                          = "npchallenge"
  node_pool_os_disk_size_gb               = "50"
  node_pool_vm_size                       = "standard_b12ms"
  node_pool_max_count                     = "1"
  node_pool_min_count                     = "1"
 node_pool_enable_node_public_ip          = true
 node_pool_max_pods                       = "30"
 default_node_pool_enable_auto_scaling    = true
 node_pool_node_count                     = "1"
 dns_prefix = "aks-challenge-prod"
}
