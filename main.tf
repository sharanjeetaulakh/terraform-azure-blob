resource "azurerm_storage_blob" "storage_blob" {
  for_each = var.blobs
  name                   = each.value.name
storage_container_id = data.azurerm_storage_container.storage_container[each.value].id 
type                   = each.value.type
  source                 = each.value.source
}