# Azure MPI Naming Convention Module

This module is to be used for Azure MPI modules to get standard names from outputs without any specific object index .
## Author
#### Azure Compentency Centre (azurecompetencycenter@axa.com)
 <font color="red"><b>Useful links</b></font>          |
|:------------------------------------------------------	|
| [Changelog](CHANGELOG.md)                             |
| [Naming Convention](https://axa365.sharepoint.com/sites/IdentityWhiteboardsession/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2FIdentityWhiteboardsession%2FShared%20Documents%2FGeneral%2F03%20%2D%20Project%2F02%20%2D%20AD%20Convergence%2F06%20%2D%20Azure%20AD%2F2%20%2D%20AAD%20Architecture%20%26%20technical%20documents%2FHLD%20Doc%20Set&FolderCTID=0x0120004AA3EEC297FE434F9D1CCFD6134E09FF)                                    	|
| [Tagging information](https://confluence.axa.com/confluence/x/2khrCg)                                   	|
| [Terraform Enterprise How to Guides](https://confluence.axa.com/confluence/x/q63FDg) 
## <font color="red"><b>Usage</b></font>
---
```go
module "names" {
  source            = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/naming/azure"
  environment_index = "05"
  application_name  = "testing"
  location          = "northeurope"
  global-env        = "Production"
  global-opco       = "ago"
}
```
## <font color="red"><b>Using outputs</b></font>
```go
output "resource_group_name" {
  description = "Name of a Resource Group"
  value       = module.names.resource_group_name
}

output "storage_account_name" {
  description = "Name of a Storage Account"
  value       = module.names.storage_account_name
}
```
## <font color="red"><b>Using variables</b></font>
```go
Adding the index
storage_account_name = format("%s%s",module.names.storage_account_name,"99")
```