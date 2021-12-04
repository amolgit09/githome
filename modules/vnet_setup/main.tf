resource "azurerm_resource_group" "rg" {
   name     = var.resource_group_name
   location = var.location
}

#####New Addition#####
resource "azurerm_network_security_group" "example" {
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
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.new_address_space
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]

  #ddos_protection_plan {
  #  id     = azurerm_network_ddos_protection_plan.example.id
  #  enable = true
  #}

  subnet {
    name           = "Frontend"
    address_prefix = var.new_frontend_prefix
  }

  subnet {
    name           = "Applicationend"
    address_prefix = var.new_application_prefix
  }

  subnet {
    name           = "Backend"
    address_prefix = var.new_backend_prefix
    #security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}
output "rg_group" {
    value = azurerm_resource_group.rg
}