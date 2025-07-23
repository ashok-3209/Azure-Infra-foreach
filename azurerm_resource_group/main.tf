resource "azurerm_resource_group" "rg" {
    for_each = var.resource_group
    name = each.value.rgname
    location = each.value.location
}

