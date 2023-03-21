module "vm_logs" {
  source                      = ".//dcrs"
  count                       = !var.orchestration_dry_run ? length(local.data_collection_rule) : 0
  support_resource_group_name = data.azurerm_resource_group.supportmodule.name
  resource_id                 = local.virtual_machine_id
  data_collection_rule_name   = local.data_collection_rule[count.index].name
  subscription_id             = data.azurerm_client_config.current.subscription_id
}