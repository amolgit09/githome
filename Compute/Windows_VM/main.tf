terraform {
   backend "azurerm" {
    resource_group_name = "rg-india-terra"
    storage_account_name = "tfdemoamsin"
    container_name = "computetfstatewin"
    key = "terraform.tfstate"
   }
}
provider "azurerm" {
   #version = "=2.0.0"
   features {}
}

data "azurerm_subnet" "vm_subnet" {
  name                 = var.subnet
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

locals {
  instance_count = var.num
}

resource "azurerm_network_interface" "main" {   
  count               = local.instance_count
  name                = "${var.prefix}-nic${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal${count.index}"
    subnet_id                     = "${data.azurerm_subnet.vm_subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}
resource "azurerm_public_ip" "pip" {
  depends_on          = [var.resource_group_name] 
  count               = local.instance_count
  name                = "${var.prefix}-pip${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
}
resource "azurerm_windows_virtual_machine" "main" {
  depends_on                      = [var.resource_group_name] 
  count                           = local.instance_count
  name                            = "${var.prefix}-vm${count.index}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_B2ms"
  admin_username                  = var.username
  admin_password                  = var.password
  #disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer = "windows11preview"
    sku = "win11-21h2-pro"
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
  depends_on           = [var.resource_group_name] 
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
  depends_on         = [var.resource_group_name] 
  count              = local.instance_count
  virtual_machine_id = azurerm_windows_virtual_machine.main[count.index].id
  managed_disk_id    = azurerm_managed_disk.data[count.index].id
  lun                = 0
  caching            = "None"
}