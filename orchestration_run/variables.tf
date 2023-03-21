variable "global-opco" {}
variable "global-dcs" {}
variable "global-env" {}
variable "global-dataclass" {}
variable "global-cbp" {}
variable "global-project" {}
variable "global-app" {}
variable "global-appserviceid" {}
variable "subnet_exposure" {}
variable "availability_zone" {}
variable "axavmrole" {}
variable "os_type" {}
variable "dr_serviceclass" {}
variable "vmbackuppolicy" {}
variable "resource_group_name" {}
variable "orchestration" {
  description = "Feature testing payload. Do only use for testing purposes. Expected input {}."
  default     = "{}"
  type        = string
}
variable "vmsource" {}
variable "workspace_slug" {}
variable "workspace_runid" {}
variable "virtual_machine_name" {}
variable "private_ip_address" {}
variable "location" {}
variable "mode" {
  validation {
    condition     = can(regex("^(?i)(dry-run|re-run)$", var.mode))
    error_message = "Mode values for var: (dry-run, re-run)."
  }
}