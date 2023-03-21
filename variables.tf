##### START Authentication
variable "TFC_WORKSPACE_SLUG" {
  description = "Orchestration The full slug of the configuration used in this run using System.TeamFoundationCollectionUri / var.TFC_WORKSPACE_SLUG / GITHUB_WORKSPACE"
  type        = string
}
variable "TFC_RUN_ID" {
  description = "TFC_RUN_ID passed through from runtime to module"
  default     = "tobeadded"
  type        = string
}
##### END Authentication

##### START Support Module
variable "support_resource_group" {
  description = "Resource group name of the support module"
  type        = string
  sensitive   = false
  nullable    = true
  validation {
    condition     = can(regex("^z-[a-z]{3}-support-[a-z]{2}[0-9]{2}-[a-z]{2}[0-9]{1}-[0-9]{2}$", var.support_resource_group))
    error_message = "Support resource group must match format z-ccc-support-ccdd-ccd-dd."
  }
}
##### END Support Module

##### START Resource naming
variable "location" {
  description = "Location of the resource group for support 'northeurope' for North Europe"
  default     = "northeurope"
  type        = string
  validation {
    condition     = contains(["northeurope", "westeurope", "eastasia", "southeastasia", "eastus2", "switzerlandnorth"], var.location)
    error_message = "Location must be an available location."
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
variable "object_index" {
  description = "SET 7 : must be 3 integers '001'-'999'"
  validation {
    condition     = can(regex("^[0-9]{3}$", var.object_index))
    error_message = "SET 7 : Unique object Index in the format of (001-999)."
  }
}
##### END Resource naming

##### START Virtual Machine
variable "short_app_name" {
  description = "SET 3 : Shorter application code to cater for VM and NIC name"
  validation {
    condition     = length(var.short_app_name) >= 2 && length(var.short_app_name) <= 20
    error_message = "SET 3 : Must be between 2-20 characters long."
  }
}

variable "os_type" {
  description = "OS of virtual machine OS i.e. Windows or Linux"
  validation {
    condition     = can(regex("^(?i)(windows|linux)$", var.os_type))
    error_message = "Virtual Machine OS (Windows, Linux)."
  }
}
##### END Virtual Machine

##### START Network
variable "subnet_exposure" {
  description = "Subnet exposure"
  default     = "internal"
  validation {
    condition     = can(regex("^(?i)(internal|management|external)$", var.subnet_exposure))
    error_message = "Valid values for var: subnet_exposure are (internal, management, external)."
  }
}

variable "subnet_project" {
  description = "Extra value to allow multiple subnets in the same dataclass and exposure"
  default     = "main"
  type        = string
}
##### END Network

##### START Tagging
variable "global-opco" {
  description = "SET 2 : Opco trigram who owns subscriptions/accounts/projects. : 3 characters"
  validation {
    condition = (
      length(var.global-opco) == 3 && can(regex("^[a-z]{3}$", var.global-opco))
    )
    error_message = "SET 2 : Opco must be 3 characters such as (ago)."
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
variable "global-app" {
  description = "Application code"
  validation {
    condition = (
      length(var.global-app) > 0
    )
    error_message = "Mandatory tag must have a valid value."
  }
}

variable "global-dcs" {
  description = "OPCO BU owning the Subscription/Account/Project, needed for cost breakdown locally."
  validation {
    condition = (
      length(var.global-dcs) > 0
    )
    error_message = "Mandatory tag must have a valid value."
  }
}

variable "global-cbp" {
  description = "Application specific Cloud permit number to be updated in Silva applicable for all environments except sandbox."
  validation {
    condition     = can(regex("^((AA)[0-9]{4})$|((A)[0-9]{5})$", var.global-cbp))
    error_message = "Valid Cloud Building permit in the format of (A00000 or AA0000)."
  }
}

variable "global-project" {
  description = "Project acronym, cost center Activity code"
  validation {
    condition = (
      length(var.global-project) > 0
    )
    error_message = "Mandatory tag must have a valid value."
  }
}

variable "global-dataclass" {
  description = "Data classification of the application: data at rest. e.g.: Internal, Public, etc."
  validation {
    condition     = can(regex("^(?i)(Public|Confidential|Internal|Secret)$", var.global-dataclass))
    error_message = "Valid values for var: dataclass are (Public, Confidential, Internal, Secret)."
  }
}

variable "global-appserviceid" {
  description = "Cloud incident and change management: automated link between the Cloud technical service and the cloud CI"
  validation {
    condition     = can(regex("^[0-9a-zA-Z]{32}$", var.global-appserviceid))
    error_message = "Application service ID (Sys ID) automatically generated in SILVA."
  }
}
##### END Tagging