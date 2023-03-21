||||
|:--|:--|:--
|[Module Readme](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Using the module terraform.tfvars</b></font>
File is used to define consistent values to variables, this example is a minimal requirement.
---
```go
# ENVIRONMENT
short_app_name             = "demo"
 # VM
location                   = "northeurope"
vm_size                    = "Standard_DS2_v2"
os_type                    = "Windows"
# DR & HA
dr_serviceclass            = "Gold"
vm_backuppolicy            = "basic"
# SUPPORT
support_resource_group     = "z-ago-support-dv01-en1-01"
# NETWORK
subnet_exposure            = "internal"
# TAGS
global-env                 = "Development"
global-app                 = "Example demo of using this module"
global-dcs                 = "MPI Example"
global-cbp                 = "A00000"
global-project             = "Example demo of using this module project tag"
global-dataclass           = "Internal"
global-opco                = "ago"
global-appserviceid        = "000000000000000000000000000000000"
# AUTH
TFC_WORKSPACE_SLUG         = var.TFC_WORKSPACE_SLUG
```