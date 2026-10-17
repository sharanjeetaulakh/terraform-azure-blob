resource "azurerm_storage_blob" "storage_blob" {
  for_each = var.blobs
  name                   = each.value.name
  storage_container_id = each.value.storage_container_id
  type                   = each.value.type
  source                 = each.value.source
}