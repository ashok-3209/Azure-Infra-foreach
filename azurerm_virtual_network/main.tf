resource "azurerm_virtual_network" "dev-vnet" {
    for_each = var.virtual_network
    name = each.value.vnet_name
    location = each.value.location
    resource_group_name = each.value.rgname
    address_space = each.value.address_space
  
}