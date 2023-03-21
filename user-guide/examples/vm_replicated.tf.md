||||
|:--|:--|:--
|[Module Readme](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Virtual Machine configured for DR</b></font>

To use replication use the dr_serviceclass see below Bronze only makes disks zonal and does not configure DR however Gold does.
--
```go
 module "windows_virualmachine_demo_dr1" {
 source = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/vm/azure"
  # insert required variables here
  short_app_name      = var.short_app_name
  object_index        = "101"
  location            = var.location
  os_type             = "Windows"
  image_template      = "Windows_2019_Mutable"
  # DEMO DR BRONZE
  dr_serviceclass     = "Bronze"
  # NETWORK
  subnet_exposure     = var.subnet_exposure
  # TAGS
  global-dataclass    = var.global-dataclass
  global-project      = var.global-project
  global-cbp          = var.global-cbp
  global-env          = var.global-env
  global-opco         = var.global-opco
  global-app          = var.global-app
  global-dcs          = var.global-dcs
  global-appserviceid = "db9a158d1b4e8d148dd364e0b24bcb17"
  # SUPPORT
  support_resource_group = var.support_resource_group
  TFC_WORKSPACE_SLUG  = var.TFC_WORKSPACE_SLUG
}

 module "windows_virualmachine_demo_dr2" {
 source = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/vm/azure"
  # insert required variables here
  short_app_name      = var.short_app_name
  object_index        = "102"
  location            = var.location
  os_type             = "Windows"
  image_template      = "Windows_2019_Mutable"
  # DEMO DR GOLD
  dr_serviceclass     = "Gold"
  # NETWORK
  subnet_exposure     = var.subnet_exposure
  # TAGS
  global-dataclass    = var.global-dataclass
  global-project      = var.global-project
  global-cbp          = var.global-cbp
  global-env          = var.global-env
  global-opco         = var.global-opco
  global-app          = var.global-app
  global-dcs          = var.global-dcs
  global-appserviceid = var.global-appserviceid
  # SUPPORT
  support_resource_group = var.support_resource_group
  TFC_WORKSPACE_SLUG  = var.TFC_WORKSPACE_SLUG
}
```