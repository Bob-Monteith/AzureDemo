##### START Orchestration
variable "puppetbranch" {
  description = "Branch of the server in Puppet"
  default     = ""
}

variable "orchestration" {
  description = "Feature testing payload. Do only use for testing purposes. Expected input {}."
  default     = "{}"
  type        = string
}
##### END Orchestration

##### START Management
variable "gallery_environment_index" {
  description = "SET 4 : Index of gallery"
  default     = "01"
  type        = string
  validation {
    condition     = can(regex("^[0-9]{2}$", var.gallery_environment_index))
    error_message = "SET 4 : Gallery environment Index in the format of (01-99)."
  }
}
variable "gallery_object_index" {
  description = "SET 7 : must be 2 integers '01'-'99'"
  default     = "01"
  type        = string
  validation {
    condition     = can(regex("^[0-9]{2}$", var.gallery_object_index))
    error_message = "SET 7 : Gallery Index in the format of (01-99)."
  }
}

variable "image_template" {
  description = "Image template name: Please look up allowed values. e.g: Windows_2019_Mutable."
  default     = null
}

variable "image_version" {
  description = "Image version name: Please look up allowed values. e.g: latest."
  default     = "latest"
}
##### END Management

##### START Resource naming
variable "resource_group_object_index" {
  description = "SET 7 : must be 2 integers '01'-'99'"
  default     = "01"
  validation {
    condition     = can(regex("^[0-9]{2}$", var.resource_group_object_index))
    error_message = "SET 7 : Resource group unique object Index in the format of (01-99)."
  }
}

variable "resource_group_app_name" {
  description = "SET 3 : Used for resource group application code so its not the same as VMs"
  default     = "none"
  validation {
    condition     = length(var.resource_group_app_name) > 2 && length(var.resource_group_app_name) < 8
    error_message = "SET 3 : Must be between 3-7 characters long."
  }
}
##### END Resource naming

##### START Virtual Machine
variable "axavmrole" {
  description = "Role of the server in Puppet"
  default     = "base"
  validation {
    condition     = can(regex("^(?i)(base|sql|oracle|db2)$", var.axavmrole))
    error_message = "Emtpy by default or valid values for var: (base, sql, oracle, db2)."
  }
}
variable "vm_size" {
  description = "Hardware Model of the virtual machine; e.g. Standard_DS2_v2 = 2 CPU, 7 GB RAM note use Hyper Threading for Linux"
  default     = "Standard_DS2_v2"
  validation {
    condition     = can(regex("^(?i)(standard_d|standard_e|standard_f)", var.vm_size))
    error_message = "Possible values are (Standard_D*, Standard_E*, Standard_F*) the use of Promo is blocked."
  }
}

variable "vm_name" {
  description = "Optional naming component for virtual machines"
  default     = ""
  validation {
    condition     = length(var.vm_name) <= 20
    error_message = "SET 3 : Must be between 0-20 characters long."
  }
}


variable "hyper_v_generation" {
  description = "The HyperV Generation of the OS Disk used for a Re-Hosted VM only."
  default     = "V1"
  validation {
    condition = can(regex("^(?i)(v1|v2|)$", var.hyper_v_generation))
    # condition     = contains(["V1", "V2"], var.hyper_v_generation)
    error_message = "Possible values are (V1, V2)."
  }
}
variable "daily_shutdown_time" {
  description = "The time each day when the schedule takes effect."
  default     = "2000"
  validation {
    condition     = can(regex("^([0-1][0-9]|2[0-3])[0-5][0-9]$", var.daily_shutdown_time))
    error_message = "Must match the format HHmm where HH is 00-23 and mm is 00-59 (e.g. 0930, 2300, etc.)."
  }
}
variable "enable_shutdown" {
  description = "Enable shutdown for this VM."
  default     = false
  validation {
    condition     = contains([true, false], var.enable_shutdown)
    error_message = "Enable VM shutdown (false, true)."
  }
}
##### END Virtual Machine

##### START Virtual Machine re-hosting
variable "migration" {
  description = "Is this a migrated VM."
  default     = false
  validation {
    condition     = contains([true, false], var.migration)
    error_message = "Migrated VM (false, true)."
  }
}
variable "migration_resource_group" {
  description = "Virtual machine OS resource group."
  default     = null
}
variable "reserve_capacity" {
  description = "Is this a VM that will use reservation."
  default     = false
  validation {
    condition     = contains([true, false], var.reserve_capacity)
    error_message = "Use capacity reservation VM (false, true)."
  }
}
variable "migration_os_snapshot_name" {
  description = "Virtual machine OS snapshot name."
  default     = null
}
variable "migration_data_snapshot_names" {
  description = "Available data snapshots for this VM needs to be specified with a list of name."
  default     = []
  type        = list(map(string))
}
##### END Virtual Machine re-hosting

##### START Virtual Machine HA
variable "vm_backuppolicy" {
  description = "Virtual backup required (policy to apply)"
  default     = "none"
  validation {
    condition     = can(regex("^(?i)(none|light|basic|medium|intermediate|enhanced)$", var.vm_backuppolicy))
    error_message = "Virtual Machine backup policy type (none, light, basic, medium, intermediate, enhanced)."
  }
}
variable "dr_serviceclass" {
  description = "Virtual machine DR required"
  default     = "None"
  validation {
    condition     = can(regex("^(?i)(none|bronze|platinum|gold)$", var.dr_serviceclass))
    error_message = "Virtual Machine DR policy (None, Bronze, Platinum, Gold)."
  }
}
##### END Virtual Machine HA

##### START Network
variable "accelerated_networking" {
  description = "Should Accelerated Networking be enabled?"
  default     = false
  validation {
    condition     = contains([true, false], var.accelerated_networking)
    error_message = "Accelerated Networking (false, true)."
  }
}

variable "network_environment_index" {
  description = "SET 4 : must be 2 integers '01'-'99'"
  default     = "01"
  validation {
    condition     = can(regex("^[0-9]{2}$", var.network_environment_index))
    error_message = "SET 4 : Network environment Index in the format of (01-99)."
  }
}

variable "network_object_index" {
  description = "SET 7 : must be 2 integers '01'-'99'"
  default     = "01"
  validation {
    condition     = can(regex("^[0-9]{2}$", var.network_object_index))
    error_message = "SET 7 : Network unique object Index in the format of (01-99)."
  }
}
variable "network_app_spoke_name" {
  description = "Used for application spokes"
  default     = null
}
variable "private_ip_address" {
  description = "Static private IP specified this defaults to 0.0.0.0 if an IP is set then it will be Static"
  default     = "0.0.0.0"
  type        = string
  validation {
    condition     = can(regex("^([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})$", var.private_ip_address))
    error_message = "Used to create a VM with a static IP."
  }
}

##### END Network


##### START Virtual Machine Disks
variable "os_disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  type        = number
  default     = null
}
variable "data_disk_size" {
  description = "Size of the default data disk"
  default     = "35"
  validation {
    condition     = can(regex("\\b([1-9]|[1-8][0-9]|9[0-9]|[1-8][0-9]{2}|9[0-8][0-9]|99[0-9]|[1-8][0-9]{3}|9[0-8][0-9]{2}|99[0-8][0-9]|999[0-9]|[12][0-9]{4}|3[01][0-9]{3}|32[0-6][0-9]{2}|327[0-5][0-9]|3276[0-7])\\b", var.data_disk_size))
    error_message = "The size of the data disk in GB between 1-32767."
  }
}

variable "file_share_quota" {
  description = "The maximum size of the linux share, in gigabytes.."
  default     = 5120
  validation {
    condition     = var.file_share_quota > 1 && var.file_share_quota <= 102400
    error_message = "The maximum size of the share, in gigabytes. For Standard storage accounts, this must be 1GB (or higher) and at most 5120 GB or 100TB if using custom."
  }
}

variable "encryption" {
  description = "Encrypt data disk."
  default     = false
  validation {
    condition     = contains([true, false], var.encryption)
    error_message = "Data disk encryption (false, true)."
  }
}
variable "additional_disk_configuration" {
  description = "Custom additional disk configuraton for this VM needs to be specified with a list of (name, size)."
  default     = []
  type        = list(map(string))
}
variable "disk_storage_account_type" {
  description = "Specifies the type of storage to use for the managed disk."
  default     = "StandardSSD_LRS"
  validation {
    condition     = can(regex("^(?i)(Standard_LRS|StandardSSD_ZRS|Premium_LRS|Premium_ZRS|StandardSSD_LRS)$", var.disk_storage_account_type))
    error_message = "Storage Account which should back this the Internal OS Disk. Possible values are (Standard_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, StandardSSD_LRS)."
  }
}
variable "data_disk_caching" {
  description = "Specifies The Type of Caching which should be used for the data disk."
  default     = "ReadWrite"
  validation {
    condition     = can(regex("^(?i)(None|ReadOnly|ReadWrite)$", var.data_disk_caching))
    error_message = "Specifies the caching requirements for this Data Disk. Possible values are (None, ReadOnly, ReadWrite)."
  }
}
variable "vm_storage_account_type" {
  description = "Specifies the type of Storage Account which should back this the Internal OS Disk."
  default     = "StandardSSD_LRS"
  validation {
    condition = can(regex("^(?i)(Standard_LRS|StandardSSD_LRS|Premium_LRS|StandardSSD_ZRS|Premium_ZRS)$", var.vm_storage_account_type))
    # condition     = contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"], var.vm_storage_account_type)
    error_message = "Storage Account which should back this the Internal OS Disk. Possible values are (Standard_LRS, StandardSSD_LRS and Premium_LRS)."
  }
}

variable "availability_zones" {
  description = "Specifies the zones to be used for this Virtual Machine."
  default     = "0"
  validation {
    condition     = contains(["0", "1,2", "2,1", "1,3", "3,1", "3,2", "2,3"], var.availability_zones)
    error_message = "Availability Zones don't support all VM sizes so this is 0 by default, possible values are ('0','1,2','2,1','1,3','3,1','3,2','2,3') 0 means this will not be set."
  }
}

##### END Virtual Machine Disks

##### START Tagging
variable "custom_tags" {
  description = "Additional tags to be merged with required information."
  default     = {}
  type        = map(string)
}
##### END Tagging

variable "orchestration_dry_run" {
  description = "Creates deployment used to call Orchestration API does not create any resources."
  default     = false
  validation {
    condition     = contains([true, false], var.orchestration_dry_run)
    error_message = "Just do a dry run test (false, true)."
  }
}

variable "orchestration_re_run" {
  description = "Creates deployment used to call Orchestration API does not create any resources."
  default     = false
  validation {
    condition     = contains([true, false], var.orchestration_re_run)
    error_message = "Just do a re-run call for orchestration (false, true)."
  }
}

variable "notification_email" {
  description = "Tells orchestration who to send a notification to for failures.."
  default     = ""
  validation {
    condition     = length(var.notification_email) < 100
    error_message = "Valid distribution group email address."
  }
}

variable "global_monitoring" {
  description = "Global data collection rule send logs "
  default     = false
  validation {
    condition     = contains([true, false], var.global_monitoring)
    error_message = "Valid values for var: global_monitoring are (true, false)."
  }
}
###### Application specific
variable "app_centric" {
  description = "List of app centric components to use rather than standard support module."
  default     = {}
  type = object({
    backup_resource_group_name                = optional(string)
    backup_recovery_vault_name                = optional(string)
    capacity_resource_group_name              = optional(string)
    capacity_group_name                       = optional(string)
    encryption_resource_group_name            = optional(string)
    encryption_vault_name                     = optional(string)
    fileshare_resource_group_name             = optional(string)
    fileshare_storage_account_name            = optional(string)
    fileshare_recovery_vault_name             = optional(string)
    sql_resource_group_name                   = optional(string)
    sql_recovery_vault_name                   = optional(string)
    replication_resource_group_name           = optional(string)
    replication_recovery_vault_name           = optional(string)
    replication_recovery_storage_account_name = optional(string)
  })
}