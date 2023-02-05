output "azure_location" {
  description = "Azure location"
  value       = var.azure_location
}

output "bootstrap_resource_group" {
  description = "Bootstrap resource group name"
  value       = var.resource_group
}

output "admin_user" {
  description = "VM-Series admin username"
  value       = var.admin_user
}

output "storage_account" {
  description = "Created storage account object"
  sensitive   = true
  value       = azurerm_storage_account.this
}

output "storage_share" {
  description = "Created storage share object"
  value       = azurerm_storage_share.this
}

output "storage_access_key" {
  description = "Storage account access key"
  sensitive   = true
  value       = azurerm_storage_account.this.primary_access_key
}

output "api_user" {
  description = "admin api user details"
  sensitive   = true
  value       = "${var.admin_api_user}/${var.admin_api_password}"
}