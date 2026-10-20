data "azurerm_storage_container" "storage_container" {
  for_each = var.blobs
  name                 =each.value.name
  storage_account_name = each.value.storage_account_name 
}
