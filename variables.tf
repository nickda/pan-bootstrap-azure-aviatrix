variable "azure_location" {
  type        = string
  description = "Azure location"
}

variable "create_admin_api" {
  description = "Set to true to create admin-api user"
  type        = bool
  default     = false
}

variable "use_existing_resource_group" {
  description = "Set to true to avoid creating dedicated resource group"
  type        = bool
  default     = false
}

variable "bootstrap_share" {
  type        = string
  default     = "panbootstrapshare"
  description = "Bootstrap storage container name. Keep it to under 20 characters"
}

variable "random_suffix" {
  description = "Set to true to append random suffix"
  type        = bool
  default     = true
}

variable "random_string_length" {
  description = "Random string length"
  type        = number
  default     = 3
}

variable "resource_group" {
  type        = string
  default     = "pan-bootstrap-rg"
  description = "Bootstrap resource group name. Only gets created if use_existing_resource_group is false"
}

variable "config_version" {
  type        = string
  default     = "11.0.0"
  description = "PANOS config version"
}

variable "detail_version" {
  type        = string
  default     = "11.0.0"
  description = "PANOS detail version"
}

variable "admin_user" {
  type        = string
  default     = "panadmin"
  description = "VM-Series admin username"
}

# admin phash for bootstrap.xml | default = Aviatrix123# 
variable "admin_password_phash" {
  type        = string
  default     = "$5$rpbkrfyo$AuahwOgZREF65jNMQpkFW.fFHX0RGbOhLLGsdY7nL/."
  description = "VM-Series admin password phash"
}

variable "admin_public_key" {
  type        = string
  default     = "c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFCQVFDZzkrT293MlpUVkcxaW01RjBwbE83aFVETlZnRVNZOFNBMThEOUVxWVR1Q3ZobGs3eVIwenBjTEJMNGVmMU02dDJubDZ5SWp0VytlZFhqV0VvTFA3SjRTbHljbjF6RWNBQm93TWVVM00yMFBOTFFMUWdKTlI2QnNsSTBpc1B5U1Yrc092amVYWjlGVFZKMTZrUXhNZjdPTUkzT1ozellNOEsvd0VVcDg5SmFjZmdBMTZHZHN2SWo2dy9lUzZLaVZQbVRWWlNTZmVOendMRGluNDRVbElvcUx5ZkVqS0NQcTUzb0prcyttVSt4eVhsbk9XZVN2Y2FiZ0U1WUJtVy9oamU1QTFOc29WL2s0ellzMzlROXNiODJ0TjhXSkJYN014bWpzUitYMFNaeU8vRWNtNmk1amxpSHB0c256MTRWcDVmTmFXZDJQVUYzNmxlOFdQSStWcXQgdnBjLTBmNjYxYTYyZjgxODEzMzM5X2Z3LWluc3RhbmNlLTE="
  description = "VM-Series admin public-key"
}

variable "admin_api_user" {
  type        = string
  default     = "admin-api"
  description = "VM-Series admin API username"
}

variable "admin_api_profile_name" {
  type        = string
  default     = "Aviatrix-API-Role"
  description = "VM-Series admin API profile name"
}

# admin API password for bootstrap.xml | default = Aviatrix123#
variable "admin_api_password" {
  type        = string
  default     = "Aviatrix123#"
  sensitive   = true
  description = "VM-Series admin API password cleartext"
}

# admin API phash for bootstrap.xml | default = Aviatrix123#
variable "admin_api_password_phash" {
  type        = string
  default     = "$5$wvkrarwn$ySGHsUWRFrKJ6v3nw21sJ842cBkC9CU3k04adOmaY90"
  description = "VM-Series admin API password phash"
}

# If var.random_suffix = true, append with random string to avoid duplication
locals {
  bootstrap_storage = var.random_suffix ? "${var.bootstrap_share}${random_string.this[0].id}" : var.bootstrap_share
  bootstrap_file    = var.create_admin_api ? "bootstrap.xml" : "bootstrap-no-admin-api.xml"

  bootstrap_folders = toset([
    "config",
    "content",
    "license",
    "software"
  ])
}