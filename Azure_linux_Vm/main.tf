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
resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_D2s_v3"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main.id,
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
  name                 = "data"
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
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  managed_disk_id    = azurerm_managed_disk.data.id
  lun                = 0
  caching            = "None"
}