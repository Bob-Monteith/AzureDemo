||||
|:--|:--|:--
|[Module Readme](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Using the module windows main</b></font>
File is used to declare provider
---
```go
terraform {
    required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "~>3.45.0"
        }  
    }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy       = false
      recover_soft_deleted_key_vaults    = true
      purge_soft_deleted_keys_on_destroy = false
      recover_soft_deleted_keys          = true
    }
  }
  skip_provider_registration = true
  version                    = "~> 3.45"
}
```