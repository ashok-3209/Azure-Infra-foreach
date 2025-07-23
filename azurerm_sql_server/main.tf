resource "azurerm_mssql_server" "sql-server" {
    for_each = var.sql_server_config
  name                         = each.value.sql_server
  resource_group_name          = each.value.rgname
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.sql-username[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.sql-password[each.key].value
  minimum_tls_version          = each.value.tls_version

}



