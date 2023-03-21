resource "azurerm_monitor_data_collection_rule_association" "dcr" {
  target_resource_id      = var.resource_id
  data_collection_rule_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.support_resource_group_name}/providers/Microsoft.Insights/dataCollectionRules/${var.data_collection_rule_name}"
  name                    = var.data_collection_rule_name
}