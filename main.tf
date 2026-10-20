data "azurerm_storage_blob" "blob" {
  for_each = var.blobs
  name                 = each.value.name
  storage_container_id = data.azurerm_storage_container.container[key.value].id
}