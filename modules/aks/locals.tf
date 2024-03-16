locals {
  commom_tags = {
    owner        = "challenge DevOps"
    managed-by   = "terraform"
    environment  = var.environment
    project-name = var.project_name
    critical     = var.critical
  }
}