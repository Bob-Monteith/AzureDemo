resource "azurerm_resource_group_template_deployment" "run-validation" {
  name                = format("mpi-%s-%s", var.mode, var.virtual_machine_name)
  resource_group_name = var.resource_group_name
  template_content    = <<TEMPLATE
	{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "variables": {},
	  "resources": {},
    "outputs": {}
    }
TEMPLATE
  deployment_mode     = "Incremental"
  tags = merge(
    local.tags, local.vmtags, local.provisioningtags, {
      "vm_name"   = var.virtual_machine_name
      "ip"        = var.private_ip_address
      "vm_os"     = var.os_type
      "cspregion" = var.location
    }
  )

  lifecycle {
    ignore_changes = [template_content]
  }
}