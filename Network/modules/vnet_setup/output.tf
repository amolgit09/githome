output "rg_group" {
    value = azurerm_resource_group.rg
}

output "Frontend_id" {
    value = azurerm_subnet.Frontend.id
}

output "Frontend_name" {
    value = azurerm_subnet.Frontend.name
}

output "Applicationend_id" {
    value = azurerm_subnet.Applicationend.id
}

output "Application_name" {
    value = azurerm_subnet.Applicationend.name
}

output "Backend_id" {
    value = azurerm_subnet.Backend.id
}

output "Backend_name" {
    value = azurerm_subnet.Backend.name
}