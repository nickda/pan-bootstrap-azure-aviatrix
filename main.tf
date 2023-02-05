// Generate the random suffix
resource "random_string" "this" {
  count = var.random_suffix ? 1 : 0

  length  = var.random_string_length
  numeric = true
  special = false
  upper   = false
}

# ---------------------------------------------------------------------------------------------------------------------
# Create a Storage Account and File Share for Bootstrap Files
# ---------------------------------------------------------------------------------------------------------------------

// Create a resource group for bootstrap storage
resource "azurerm_resource_group" "this" {
  count    = var.use_existing_resource_group ? 0 : 1
  name     = var.resource_group
  location = var.azure_location
}

// Create a storage account for bootstrap files
resource "azurerm_storage_account" "this" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.azure_location
  name                     = local.bootstrap_storage
  resource_group_name      = var.resource_group

  depends_on = [
    azurerm_resource_group.this
  ]
}

// Create a storage fileshare for bootstrap files
resource "azurerm_storage_share" "this" {
  name                 = local.bootstrap_storage
  quota                = 1
  storage_account_name = azurerm_storage_account.this.name
}

// Create bootstrap folders
resource "azurerm_storage_share_directory" "bootstrap_folders" {
  for_each             = local.bootstrap_folders
  name                 = each.key
  share_name           = azurerm_storage_share.this.name
  storage_account_name = azurerm_storage_account.this.name
}

#--------------------------------------------------------------------------------
# Create bootstrap.xml and upload it and init-cfg.txt to the the Azure file share
#--------------------------------------------------------------------------------

// Bootstrap file rendering
resource "local_file" "bootstrap_file" {
  filename = "${path.module}/${local.bootstrap_file}-rendered"
  content = templatefile("${path.module}/${local.bootstrap_file}",
    {
      "config_version"           = var.config_version,
      "detail_version"           = var.detail_version,
      "admin_user"               = var.admin_user,
      "admin_password_phash"     = var.admin_password_phash,
      "admin_public_key"         = var.admin_public_key,
      "admin_api_user"           = var.admin_api_user,
      "admin_api_profile_name"   = var.admin_api_profile_name,
      "admin_api_password_phash" = var.admin_api_password_phash
    }
  )
}

//Upload bootstrap.xml to Azure storage account
resource "azurerm_storage_share_file" "bootstrap_xml" {
  storage_share_id = azurerm_storage_share.this.id
  source           = local_file.bootstrap_file.filename
  path             = "config"
  name             = "bootstrap.xml"

  depends_on = [azurerm_storage_share_directory.bootstrap_folders]
}

// Upload init-cfg.txt to Azure storage account
resource "azurerm_storage_share_file" "init_cfg_txt" {
  storage_share_id = azurerm_storage_share.this.id
  source           = "${path.module}/init-cfg.txt"
  path             = "config"
  name             = "init-cfg.txt"

  depends_on = [azurerm_storage_share_directory.bootstrap_folders]
}
