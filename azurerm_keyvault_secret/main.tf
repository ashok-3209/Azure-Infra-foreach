data "azurerm_key_vault" "key_vault" {
    for_each = var.key_vault
  name                = each.value.key_vault
  resource_group_name = each.value.rgname
}

resource "azurerm_key_vault_secret" "secret" {
    for_each = var.secret_name
  name         = each.value.name
  value        = each.value.value
  key_vault_id = data.azurerm_key_vault.key_vault["kv1"].id
  
  expiration_date = "1982-12-31T00:00:00Z"
  content_type = "password"
}

