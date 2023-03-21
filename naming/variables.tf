variable "location" {
  description = "Location of the resource group for support 'northeurope' for North Europe"
  type        = string
  validation {
    condition     = contains(["northeurope", "westeurope", "eastasia", "eastus2", "switzerlandnorth"], var.location)
    error_message = "Location must be an available location."
  }
}

variable "global-env" {
  description = "Cloud Environment e.g.: Development,Integration,UAT,Production,Pre-Production."
  default     = "Development"
  validation {
    condition     = can(regex("^(?i)(Development|Integration|UAT|Production|Pre-Production)$", var.global-env))
    error_message = "Environment must be one of (Development,Integration,UAT,Production,Pre-Production)."
  }
}

variable "global-opco" {
  description = "Opco trigram who owns subscriptions/accounts/projects. : 3 characters"
  validation {
    condition = (
      length(var.global-opco) == 3 && can(regex("^[a-z]{3}$", var.global-opco))
    )
    error_message = "Opco must be 3 characters such as (ago)."
  }
}

variable "environment_index" {
  description = "SET 5 : must be 2 integers '01'-'99'"
  default     = "01"
  validation {
    condition     = can(regex("^[0-9]{2}$", var.environment_index))
    error_message = "SET 5 : Environment Index in the format of (01-99)."
  }
}

variable "application_name" {
  description = "SET 3 : Application name"
  default     = "01"
  validation {
    condition     = length(var.application_name) >= 2 && length(var.application_name) <= 20
    error_message = "SET 3 : Must be between 2-20 characters long."
  }
}
