resource "azurerm_key_vault_key" "encryption" {
  count        = (var.encryption || local.secret) && !var.orchestration_dry_run ? 1 : 0
  name         = local.virtual_machine_name
  key_vault_id = data.azurerm_key_vault.support[0].id
  key_type     = "RSA"
  key_size     = 3072

  lifecycle {
    precondition {
      condition     = var.encryption
      error_message = format("ASSERT : Secret Virtual Machine must be encrypted setting %s is invalid", var.encryption)
    }
  }

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
resource "azurerm_disk_encryption_set" "encryption" {
  count                     = (var.encryption || local.secret) && !var.orchestration_dry_run ? 1 : 0
  name                      = "${local.virtual_machine_name}_Encryption"
  resource_group_name       = data.azurerm_resource_group.virtualmachine.name
  location                  = var.location
  key_vault_key_id          = azurerm_key_vault_key.encryption[0].id
  auto_key_rotation_enabled = true

  lifecycle {
    precondition {
      condition     = var.encryption
      error_message = format("ASSERT : Secret Virtual Machine must be encrypted setting %s is invalid", var.encryption)
    }
  }
  identity {
    type = "SystemAssigned"
  }
  tags = local.tags
}

resource "azurerm_key_vault_access_policy" "encryption-disk" {
  count        = (var.encryption || local.secret) && !var.orchestration_dry_run ? 1 : 0
  key_vault_id = data.azurerm_key_vault.support[0].id
  tenant_id    = azurerm_disk_encryption_set.encryption[0].identity.0.tenant_id
  object_id    = azurerm_disk_encryption_set.encryption[0].identity.0.principal_id

  lifecycle {
    precondition {
      condition     = var.encryption
      error_message = format("ASSERT : Secret Virtual Machine must be encrypted setting %s is invalid", var.encryption)
    }
  }

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}