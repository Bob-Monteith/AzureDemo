# Creation of the network interface of the virtual machine
resource "azurerm_network_interface" "virtualmachine" {
  count                         = !var.orchestration_dry_run ? 1 : 0
  name                          = local.virtual_network_nic
  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.virtualmachine.name
  enable_accelerated_networking = var.accelerated_networking

  ip_configuration {
    name                          = var.subnet_exposure
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = local.virtual_network_address_allocation
    private_ip_address            = local.virtual_network_address
  }

  tags = merge(
    local.tags, {
      local-description = "Network_Interface_${local.virtual_machine_name}"
    }
  )

  lifecycle {
    ignore_changes = [tags]
    precondition {
      condition     = local.fixed_ip_required ? var.private_ip_address != "0.0.0.0" : true
      error_message = format("ASSERT : Using DR Bronze or Gold requires a static IP %s is invalid", var.private_ip_address)
    }
    precondition {
      condition     = local.secret ? lower(var.global-env) != "development" : true
      error_message = format("ASSERT : Using Secret is not supported with %s", lower(var.global-env))
    }
    precondition {
      condition     = local.secret ? lower(var.global-env) != "management" : true
      error_message = format("ASSERT : Using Secret is not supported with %s", lower(var.global-env))
    }
  }
}