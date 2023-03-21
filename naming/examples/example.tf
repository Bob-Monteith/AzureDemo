module "terraform-azure-naming" {
  source            = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/naming/azure"
  environment_index = "05"
  application_name  = "myapp"
  location          = "northeurope"
  global-env        = "Development"
  global-opco       = "ago"
}

environment_code               = module.terraform-azure-naming.environment_code
location_code                  = module.terraform-azure-naming.location_code
resource_group_name            = format("%s%s", module.terraform-azure-naming.resource_group_name, "01")
storage_account_name           = format("%s%s", module.terraform-azure-naming.storage_account_name, "01")
keyvault_account_name          = format("%s%s", module.terraform-azure-naming.keyvault_account_name, "01")
automation_account_name        = format("%s%s", module.terraform-azure-naming.automation_account_name, "01")
recovery_vault_name            = format("%s%s", module.terraform-azure-naming.recovery_vault_name, "01")
managed_identity_name          = format("%s%s", module.terraform-azure-naming.managed_identity_name, "01")
capacity_group_name            = format("%s%s", module.terraform-azure-naming.capacity_group_name, "01")
log_analytics_workspace_name   = format("%s%s", module.terraform-azure-naming.capacity_group_name, "01")
virtual_machine_name           = format("%s%s", module.terraform-azure-naming.virtual_machine_name, "01")
virtual_machine_OSDisk_name    = format("%s%s", module.terraform-azure-naming.virtual_machine_OSDisk_name, "01")
virtual_network_name           = format("%s%s", module.terraform-azure-naming.virtual_network_name, "01")
virtual_network_interface_name = format("%s%s", module.terraform-azure-naming.virtual_network_interface_name, "01")