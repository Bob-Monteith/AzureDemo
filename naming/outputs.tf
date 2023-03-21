output "environment_code" {
  description = "Environment Code set4"
  value       = local.environment_code
}

output "virtual_network_environment_code" {
  description = "Network Environment Code set4"
  value       = local.network_environment_code
}

output "location_code" {
  description = "Location Code set6"
  value       = local.location_code
}

output "techserviceid" {
  description = "global-techserviceid"
  value       = local.techserviceid
}

output "timezone" {
  description = "The time zone ID (e.g. Pacific Standard time)."
  value       = local.timezone
}

output "resource_group_name" {
  description = "Name of a Resource Group"
  value       = local.resource_group_sets
}

output "storage_account_name" {
  description = "Name of a Storage Account"
  value       = format("%s%s", local.resource_sets, "sto")
}

output "keyvault_name" {
  description = "Name of a Key Vault"
  value       = format("%s%s", local.resource_sets, "key")
}

output "automation_account_name" {
  description = "Name of a Automation Account"
  value       = format("%s%s", local.resource_sets, "aut")
}

output "recovery_vault_name" {
  description = "Name of a Recovery Services Vault"
  value       = format("%s%s", local.resource_sets, "rsv")
}

output "function_app_name" {
  description = "Name of a Function App"
  value       = format("%s%s", local.resource_sets, "fun")
}

output "managed_identity_name" {
  description = "Name of a Managed Identity"
  value       = format("%s%s", local.resource_sets, "uai")
}

output "capacity_group_name" {
  description = "Name of a Capacity Reservation Group"
  value       = format("%s%s", local.resource_sets, "crg")
}

output "image_gallery_name" {
  description = "Name of a Shared Image Gallery"
  value       = format("%s%s", local.resource_sets, "gal")
}

output "event_hub_name" {
  description = "Name of a Event Hub Name"
  value       = format("%s%s", local.resource_sets, "hub")
}

output "log_analytics_workspace_name" {
  description = "Name of a Log Analytics Workspace"
  value       = format("%s%s", local.resource_sets, "oms")
}

output "resource_guard_name" {
  description = "Name of a Resource Guard"
  value       = format("%s%s", local.resource_sets, "grd")
}

output "virtual_machine_name" {
  description = "Name of a Virtual Machine"
  value       = local.machine_sets
}

output "virtual_machine_OSDisk_name" {
  description = "Name of a Virtual Machine OS Disk"
  value       = lower(format("%s%s", local.machine_sets, "_OSDisk"))
}

output "virtual_network_resource_group_name" {
  description = "Name of a Virtual Network Resouce Group"
  value       = local.network_group_sets
}

output "virtual_network_name" {
  description = "Name of a Virtual Network"
  value       = format("%s%s", local.network_sets, "net")
}

output "virtual_network_security_group" {
  description = "Name of a Virtual Network Sercurity Group"
  value       = format("%s%s", local.network_sets, "nsg")
}

output "firewall" {
  description = "Name of a Firewall"
  value       = format("%s%s", local.network_sets, "fwa")
}

output "firewall_policy" {
  description = "Name of a Firewall Policy"
  value       = format("%s%s", local.network_sets, "fwp")
}

output "service_endpoint_policy" {
  description = "Name of a Virtual Network Service Endpoint Policy"
  value       = format("%s%s", local.network_sets, "spl")
}

output "service_route_policy" {
  description = "Name of a Virtual Network Route Policy"
  value       = format("%s%s", local.network_sets, "urt")
}

output "virtual_network_interface_name" {
  description = "Name of a Virtual Network Group"
  value       = format("%s%s", local.resource_sets, "nic")
}

output "virtual_network_public_ip" {
  description = "Name of a Public IP"
  value       = format("%s%s", local.resource_sets, "pip")
}

output "dns_guard" {
  description = "Name of a DNS Guard"
  value       = format("%s%s", local.resource_sets, "dng")
}

output "dns_zone" {
  description = "Name of a DNS Zone"
  value       = format("%s%s", local.resource_sets, "dnz")
}

output "dns_resolver" {
  description = "Name of a DNS Resolver"
  value       = format("%s%s", local.resource_sets, "dnr")
}

output "dns_ruleset" {
  description = "Name of a DNS Forward Ruleset"
  value       = format("%s%s", local.resource_sets, "dnr")
}

output "dns_analytics" {
  description = "Name of a DNS Analytics"
  value       = format("%s%s", local.resource_sets, "dna")
}