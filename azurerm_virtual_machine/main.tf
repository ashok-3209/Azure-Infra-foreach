resource "azurerm_network_interface" "vm_nic" {
    for_each = var.vm_config
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.PIP[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_asso" {
  for_each = var.vm_config

  network_interface_id      = azurerm_network_interface.vm_nic[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg[each.key].id

  lifecycle {
    ignore_changes = [network_security_group_id]
  }
}

resource "azurerm_linux_virtual_machine" "VM" {
    for_each = var.vm_config
  name                = each.value.vm_name
  resource_group_name = each.value.rgname
  location            = each.value.location
  size                = each.value.size
  admin_username = data.azurerm_key_vault_secret.username[each.key].value
  admin_password = data.azurerm_key_vault_secret.password[each.key].value
  
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm_nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version 
  }

custom_data = base64encode (<<EOF
#!/bin/bash
apt update -y
apt install nginx -y
systemctl enable nginx
systemctl start nginx
echo "NGINX Installed via INLINE custom_data!" > /var/www/html/index.html
EOF
)

}