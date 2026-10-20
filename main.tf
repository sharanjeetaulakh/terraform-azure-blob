resource "azurerm_storage_blob" "blob" {
  for_each = var.blobs

  name                   = each.value.name
  storage_container_id   = data.azurerm_storage_container.container[each.key].id
  type                   = each.value.type
  source                 = each.value.source
}