resource "azurerm_subnet" "dev-subnet" {
    for_each = var.subnet_name
    name = each.value.subnet_name
    resource_group_name = each.value.rgname
    virtual_network_name = each.value.vnet_name
    address_prefixes = each.value.address_prefixes
  
}

