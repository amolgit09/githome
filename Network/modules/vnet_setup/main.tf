resource "azurerm_resource_group" "rg" {
   name     = var.resource_group_name
   location = var.location
   tags = {
    environment = "Production"
  }
}

#####New Addition#####
resource "azurerm_network_security_group" "example" {
  depends_on          = [azurerm_resource_group.rg]
  name                = "acceptanceTestSecurityGroup1"
  location            = var.location
  resource_group_name = var.resource_group_name
}

#resource "azurerm_network_ddos_protection_plan" "example" {
#  name                = "ddospplan1"
#  location            = var.location
#  resource_group_name = var.resource_group_name
#}

resource "azurerm_virtual_network" "example" {
  depends_on          = [azurerm_resource_group.rg]
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.new_address_space
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]

  #ddos_protection_plan {
  #  id     = azurerm_network_ddos_protection_plan.example.id
  #  enable = true
  #}

  tags = {
    environment = "Production"
  }
}
resource "azurerm_subnet" "Frontend" {
  depends_on           = [azurerm_virtual_network.example]
  name                 = "Fronend"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.new_frontend_prefix]
}

resource "azurerm_subnet" "Applicationend" {
  depends_on           = [azurerm_virtual_network.example]
  name                 = "Applicationend"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.new_application_prefix]
}

resource "azurerm_subnet" "Backend" {
  depends_on           = [azurerm_virtual_network.example]
  name                 = "Backend"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.new_backend_prefix]
}

module "keyVault_setup" {
   source = "./modules/keyvault_setup"
   keyvault_name = "keyvault-terraform00"
   resource_group_name = "rg-india"
   location = "centralindia"
   #depends_on = [var.resource_group_name]
}