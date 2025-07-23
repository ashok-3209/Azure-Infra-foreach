data "azurerm_key_vault" "kv" {
  # for_each = var.keyvault_name
  for_each = var.sql_server_config
  name                = each.value.key_vault
  resource_group_name = each.value.rgname
}

data "azurerm_key_vault_secret" "sql-username" {
  for_each     = var.sql_server_config
  name         = each.value.sql-username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "sql-password" {
  for_each     = var.sql_server_config
  name         = each.value.sql-password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}