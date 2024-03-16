variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "subnet_id" {
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

