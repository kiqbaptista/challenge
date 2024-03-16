variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
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