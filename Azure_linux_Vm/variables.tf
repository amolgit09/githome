variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

variable "resource_group_name" {
    type = string
    description = "Enter Azure's existing resource group"
}

variable "location" {
    type = string
    description = "Enter Azure location where you have to deploy VM"
}

variable "subnet" {
    type = string
    description = "Need subnet to assign IP for new VM"
}

variable "username" {
      type = string
    description = "Need subnet to assign IP for new VM"
}
variable "password" {
      type = string
    description = "Need subnet to assign IP for new VM"
}