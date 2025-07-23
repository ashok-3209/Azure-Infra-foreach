resource "azurerm_network_security_group" "nsg" {
    for_each = var.nsg
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.rgname

  security_rule {
    # for_each = var.security_rule
    name                       = each.value.security_rule_name
    priority                   = each.value.security_rule_priority
    direction                  = each.value.security_rule_direction
    access                     = each.value.security_rule_access
    protocol                   = each.value.security_rule_protocol
    source_port_range          = each.value.security_rule_source_port_range
    destination_port_range     = each.value.security_rule_destination_port_range
    source_address_prefix      = each.value.security_rule_access_source_address_prefix
    destination_address_prefix = each.value.security_rule_destination_address_prefix
  }
}

data "azurerm_subnet" "subnet" {
    for_each = var.nsg
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rgname
}

# resource "azurerm_network_interface_security_group_association" "nsg-asso" {
#   for_each = azurerm_network_security_group.nsg
#   network_interface_id      = azurerm_network_interface.vm_nic[each.key].id
#   network_security_group_id = azurerm_network_security_group.nsg[each.key].id
# }

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_asso" {
  for_each = var.nsg
  subnet_id                 = data.azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
  
  lifecycle {
    ignore_changes = [network_security_group_id]
  }
}