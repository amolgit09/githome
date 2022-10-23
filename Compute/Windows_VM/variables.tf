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
variable "data_disk_size" {
      type = number
    description = "Enter size of data disk"  
}
variable "num" {
  type = number
  description = "Enter number of disk"
}
variable "vnet_name" {
  type = string
  description = "(optional) describe your variable"
}