terraform {
   backend "azurerm" {
    resource_group_name = "rg_terraform"
    storage_account_name = "tfdemoams"
    container_name = "tfstate"
    key = "terraform.tfstate"
   }
}
provider "azurerm" {
   #version = "=3.0.0"
   features {}
}

module "vnet_setup" {
    source = "./modules/vnet_setup"
    resource_group_name = "terrform-demo-rg"
    vnet_name = "prodction-vnet"
    location = "westeurope"
    new_address_space = ["10.39.0.0/16"]
    new_frontend_prefix = "10.39.10.0/24"
    new_application_prefix = "10.39.11.0/24"
    new_backend_prefix = "10.39.12.0/24"
}

module "keyVault_setup" {
   source = "./modules/keyvault_setup"
   keyvault_name = "keyvault-terraform00"
   resource_group_name = "terrform-demo-rg"
   location = "westeurope"
}