variable "resource_group_name" {
   type = string
   description = "name of the resource group"
}
variable "location" {
 type = string
 description = "location"
}
variable "vnet_name" {
 type = string
 description = "vnet address space"
}
variable "new_address_space" {
   type = list(string)
   description = "Address Space"
}
variable "new_frontend_prefix" {
   type = string
   description = "New to subnet"
}
variable "new_application_prefix" {
   type = string
   description = "New to subnet"
}
variable "new_backend_prefix" {
   type = string
   description = "New to subnet"
}