terraform {
   backend "azurerm" {
    resource_group_name = "rg-india-terra"
    storage_account_name = "tfdemoamsin"
    container_name = "computetfstate"
    key = "terraform.tfstate"
   }
}
provider "azurerm" {
   #version = "=3.0.0"
   features {}
}

module "VM_deployement" {
   source = "./modules/Linux_Vm"
   prefix = "testlinux"
   resource_group_name = "rg-india"
   location = "centralindia"
   #vnet_name = "prodction-vnet"
   subnet = "Frontend"
   username = "amolw"
   password = "Password1234!"
   data_disk_size = "10"
}