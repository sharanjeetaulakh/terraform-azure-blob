data "azurerm_storage_account" "storage_account" {
  for_each = var.blobs

  name                = each.value.storage_account_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_storage_container" "container" {
  for_each = var.blobs

  name                 = each.value.container_name
  storage_account_id   = data.azurerm_storage_account.storage_account[each.key].id
}

