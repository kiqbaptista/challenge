variable "aks_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}


variable "k8s_version" {
  type = string
}

variable "default_node_pool_name" {
  type = string
}

variable "default_node_pool_node_count" {
  type = string
}

variable "default_node_pool_vm_size" {
  type = string
}

variable "default_node_pool_os_disk_size_gb" {
  type = string
}

variable "default_node_pool_vnet_subnet_id" {
  type = string
}

variable "default_node_pool_enable_auto_scaling" {
  type = bool
}

variable "default_node_pool_min_count" {
  type = string
}

variable "default_node_pool_max_count" {
  type = string
}

variable "default_node_pool_max_pods" {
  type = string
}

variable "default_node_pool_enable_node_public_ip" {
  type = bool
}

variable "node_pool_name" {
  type = string
}

variable "node_pool_node_count" {
  type = string
}

variable "node_pool_vm_size" {
  type = string
}

variable "node_pool_os_disk_size_gb" {
  type = string
}

variable "node_pool_vnet_subnet_id" {
  type = string
}

variable "node_pool_enable_auto_scaling" {
  type = string
}

variable "node_pool_min_count" {
  type = string
}

variable "node_pool_max_count" {
  type = string
}

variable "node_pool_max_pods" {
  type = string
}

variable "node_pool_enable_node_public_ip" {
  type = string
}

#####commom tags#######

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "critical" {
  type = string
}
variable "dns_prefix" {
  type = string
}