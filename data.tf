data "azurerm_storage_container" "container" {
  for_each = var.blobs

  name                 = each.value.container_name
  storage_account_id= each.value.storage_account_id
}