provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
data "azurerm_client_config" "current" {}
#####Add Below details to get resource group which is newly created####
#data "azurerm_resource_group" "resource_g" {
#  name = var.resource_group_name
#}

resource "azurerm_key_vault" "new_key_vault" {
  depends_on                  = [var.resource_group_name]  ######New Line depend status of new resource group
  name                        = var.keyvault_name
  #location                    = "${data.azurerm_resource_group.resource_g.location}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  #resource_group_name         = "${data.azurerm_resource_group.resource_g.name}"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  #soft_delete_retention_days  = 7
  #soft_delete_enabled = true
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",    
    ]

    certificate_permissions = [
      "Get",
    ]
  }
}