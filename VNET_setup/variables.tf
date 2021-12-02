variable "resource_group_name" {
   type = string
   description = "name of the resource group"
}
variable "location" {
 type = string
 description = "location "
}
variable "new_address_space" {
   type = list(string)
   description = "Address Space"
}
variable "new_address_prefix1" {
   type = string
   description = "New to subnet"
}
variable "new_address_prefix2" {
   type = string
   description = "New to subnet"
}
variable "new_address_prefix3" {
   type = string
   description = "New to subnet"
}