output "kube_config" {
  value = azurerm_kubernetes_cluster.akschallenge.kube_config_raw

  sensitive = true
}

output "kube_id" {
  value = azurerm_kubernetes_cluster.akschallenge.kubelet_identity[0].object_id
}