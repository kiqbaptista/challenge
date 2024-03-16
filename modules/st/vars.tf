variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "st_name" {
  type = string
}

variable "asc_name" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "account_kind" {
  type = string
}

variable "container_access_type" {
  type = string
}

variable "vpn_ip" {
  type = list(string)
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
variable "tags" {
  type    = list(string)
}