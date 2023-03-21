variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "storage_account_type" {}
variable "tags" {}
variable "caching" {}
variable "disk_size_gb" {}
variable "disk_name" {}
variable "lun" {}
variable "disk_zone" {}
variable "disk_encryption_set_id" {}
variable "source_resource_id" {}
variable "create_option" {
  default = "Copy"
}