data "azurerm_subnet" "subnet" {
    for_each = var.vm_config
    # for_each = var.subnet
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rgname
}

data "azurerm_public_ip" "PIP" {
   for_each = var.vm_config
      # for_each = var.public_ip
  name                = each.value.pip_name
  resource_group_name = each.value.rgname
}

data "azurerm_key_vault" "kv" {
  # for_each = var.keyvault_name
  for_each = var.vm_config
  name                = each.value.key_vault
  resource_group_name = each.value.rgname
}

data "azurerm_key_vault_secret" "username" {
  for_each     = var.vm_config
  name         = each.value.username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "password" {
  for_each     = var.vm_config
  name         = each.value.password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_network_security_group" "nsg" {
  for_each = var.vm_config
  name                = each.value.nsg_name
  resource_group_name = each.value.rgname
}