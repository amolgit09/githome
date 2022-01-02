terraform {
   backend "azurerm" {
    resource_group_name = "rg_terraform"
    storage_account_name = "tfdemoams"
    container_name = "tfstate"
    key = "terraform.tfstate"
   }
}
provider "azurerm" {
   version = "=2.0.0"
   features {}
}
locals {
  instance_count = 2
}
resource "azurerm_network_interface" "main" {
  count               = local.instance_count
  name                = "${var.prefix}-nic${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}
resource "azurerm_public_ip" "pip" {
  count               = local.instance_count
  name                = "${var.prefix}-pip${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}
resource "azurerm_linux_virtual_machine" "main" {
  count                           = local.instance_count
  name                            = "${var.prefix}-vm${count.index}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_D2s_v3"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "82gen2"
    version = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  tags = {
    environment = "${var.prefix}-staging"
  }
}
resource "azurerm_managed_disk" "data" {
  count                = local.instance_count
  name                 = "data${count.index}"
  location             = var.location
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"

  tags = {
    environment = "${var.prefix}-staging"
  }

}
resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  count                = local.instance_count
  virtual_machine_id = azurerm_linux_virtual_machine.main[count.index].id
  managed_disk_id    = azurerm_managed_disk.data[count.index].id
  lun                = 0
  caching            = "None"
}