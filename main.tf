data "azurerm_storage_container" "storage_container" {
  for_each = var.blobs
  name                 = "loan-documents"
  storage_account_name = "stlmsidndev001"
}

resource "azurerm_storage_blob" "storage_blob" {
  for_each = var.blobs
  name                   = each.value.name
storage_container_id = data.azurerm_storage_container.storage_container[each.key].id 
type                   = each.value.type
  source                 = each.value.source
}