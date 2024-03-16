resource "azurerm_kubernetes_cluster" "akschallange" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.k8s_version
  # api_server_authorized_ip_ranges = ["201.48.63.225/32"] // Limitar TUDO a uma vpn

  default_node_pool {
    name                  = var.default_node_pool_name
    node_count            = var.default_node_pool_node_count
    vm_size               = var.default_node_pool_vm_size
    os_disk_size_gb       = var.default_node_pool_os_disk_size_gb
    vnet_subnet_id        = var.default_node_pool_vnet_subnet_id
    enable_auto_scaling   = var.default_node_pool_enable_auto_scaling
    min_count             = var.default_node_pool_min_count
    max_count             = var.default_node_pool_max_count
    max_pods              = var.default_node_pool_max_pods
    enable_node_public_ip = var.default_node_pool_enable_node_public_ip
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.commom_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "aks-challange-infra" {
  name                  = var.node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.akschallange.id
  node_count            = var.node_pool_node_count
  vm_size               = var.node_pool_vm_size
  os_disk_size_gb       = var.node_pool_os_disk_size_gb
  vnet_subnet_id        = var.node_pool_vnet_subnet_id
  enable_auto_scaling   = var.node_pool_enable_auto_scaling
  min_count             = var.node_pool_min_count
  max_count             = var.node_pool_max_count
  max_pods              = var.node_pool_max_pods
  enable_node_public_ip = var.node_pool_enable_node_public_ip

  tags = local.commom_tags
}