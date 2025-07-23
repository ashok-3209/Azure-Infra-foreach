resource "azurerm_storage_account" "stg" {
    for_each = var.storage_account
    name = each.value.stgname
    location = each.value.location
    resource_group_name = each.value.rgname
    account_tier = "Standard"
    account_replication_type = "LRS"
  
}
