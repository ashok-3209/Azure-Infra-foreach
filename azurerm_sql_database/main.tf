resource "azurerm_mssql_database" "sqldb" {
    for_each = var.sql_db_config
  name         = each.value.sql_db_name
  server_id    = data.azurerm_mssql_server.sqlserver[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  }

  data "azurerm_mssql_server" "sqlserver" {
    for_each = var.sql_db_config
  name                = each.value.sql_server
  resource_group_name = each.value.rgname
}



