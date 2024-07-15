variable "resource_group_name" {
  type        = string
  default     = "task-5-rg"
  description = "Resource group Name"
}

variable "location_for_rg" {
  type        = string
  default     = "West Europe"
  description = "Location for the resources"
}

variable "storage_account_name" {
  type        = string
  default     = "task5yaasstorage"
  description = "Storage account Name"
}

variable "container_name" {
  type        = string
  default     = "task-5-content"
  description = "Container Name"
}



