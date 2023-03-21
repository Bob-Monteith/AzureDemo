# Azure MPI Virtual Machine Module

This module is to be used for MPI for both Windows and Linux VMs, the module has a lot of validation to ensure it aligns with required settings and it is heavily reliant on the naming convention.

Please follow the user guide and look at the examples 

## How to get help on this module.
* [Get Support Ticket](https://confluence.axa.com/confluence/x/L49iDw)
* [Raise an Incident](https://confluence.axa.com/confluence/x/pTYBE)
* [Request a feature](https://confluence.axa.com/confluence/x/qIsKEg)
## Author
#### Azure Compentency Centre (azurecompetencycenter@axa.com))

| <font color="red"><b>Bookmarks</b></font>     | <font color="red"><b>Useful links</b></font>          |
|:---------------------------------------------	|:------------------------------------------------------	|
| [User guide](/user-guide/) & [Examples](/user-guide/examples)        	| [Changelog](CHANGELOG.md)                             |
| [Defining your Virtual Machine](/user-guide/machine.md)                	| [Naming Convention](https://axa365.sharepoint.com/sites/IdentityWhiteboardsession/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2FIdentityWhiteboardsession%2FShared%20Documents%2FGeneral%2F03%20%2D%20Project%2F02%20%2D%20AD%20Convergence%2F06%20%2D%20Azure%20AD%2F2%20%2D%20AAD%20Architecture%20%26%20technical%20documents%2FHLD%20Doc%20Set&FolderCTID=0x0120004AA3EEC297FE434F9D1CCFD6134E09FF)                                    	|
| [Joining your Virtual Machine to a network](/user-guide/network.md)    	| [Deploying databases](/user-guide/database.md)                    	|
| [Tagging your Virtual Machine](/user-guide/tagging.md)                	| [Tagging information](https://confluence.axa.com/confluence/x/2khrCg)                                   	|
| [Changing your Virtual Machine disk configuration](/user-guide/disks.md)  	| [Azure compute unit (ACU)](https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/virtual-machines/acu.md)                               	|
| [Backing up your Virtual Machine](/user-guide/backup.md)         	| [SILVA Sys ID List contact annefrance.baudoin@axa.com](https://axa365.sharepoint.com/sites/ITAM-ITAssetManagement/SitePages/Business-Service-List.aspx)  	|
| [Re-hosting your Virtual Machine](/user-guide/rehosting.md)              	| [VM Provisioning process flow](https://confluence.axa.com/confluence/x/UirVDg)                            	|
| [Troubleshooting](/user-guide/troubleshooting.md)             	| [Support module](https://github.axa.com/ago-sharedtferegistry/terraform-azure-mpi_support) |

## <font color="red"><b>Features</b></font>

---

This module will deliver either a Windows or Linux Azure Virtual Machine which contains validated settings to ensure it is compliant against AXA standards.
- [x] Windows or Linux virtual machine
- [x] Re-hosted virtual machine
- [x] Network interface with a static or dynamic IP Address
- [x] Standard disk configuration based on machine type
- [x] Additional disk configuration
- [x] Optional data disk encryption with a customer-managed key
- [x] Data collection rule association
- [x] Backup policy association
- [x] SQL Backup policy association
- [x] Linux DB file share with size allocation
- [x] Disaster recovery configuration
- [x] Capacity reservation allocation (requires support module to reserve)
- [x] Optional shutdown with localized schedule
- [x] Resource locks on Virtual Machine and Network to add protection from accidental deletion
> NOTE:
> You must deploy the support module once to every Landing Zone before you deploy any VMs this does VM provisioning first https://github.axa.com/ago-sharedtferegistry/terraform-azure-mpi_support

---

####
## <font color="red"><b>Important prerequisite</b></font>
> NOTE:
> A VM is not ready to use until the local-vmstatus tag says Ready (Starts as NotReady and will say Failed if the process failed)

- You must have the [Support Module](https://github.axa.com/ago-sharedtferegistry/terraform-azure-mpi_support) deployed to your Subscription before you use this module, this can be in the same GitHub and TFE
- Your Virtual Machine SPN must be given access to the Management subscription either via a entity owned group or individually
- Your Virtual Machine SPN must be able to join the spoke network using custom role ago_gl_network_join
- Your Virtual Machine SPN must be able to contribute to the Support Module resource group
> NOTE:
> [Landing zone requirements](https://confluence.axa.com/confluence/x/cpfFDg)
## <font color="red"><b>Usage Instructions</b></font>

---

Create an AXA GitHub repository and add the following new files: You can see examples of usage in the user-guide
```go
main.tf
variables.tf
terraform.auto.tfvars
vms_linux.tf
vms_windows.tf
```
> NOTE:
> You need to either create the resource group manually or declare it separately in the main.tf this module will not build it and it must match the naming convention and you must deploy the support module before you deploy VMs.
####
> **NOTE**:
> Resource group needs creating manually in the following format and short_app_name is used for machines
####
####
| SET1 	|   	| **SET2**       	|   	| **SET3**          	|   	|   	| **SET4**            	| **SET5**             	|   	| **SET6**         	|   	| **SET7** 	|
|:-------	|:---	|:-------------	|:---	|:----------------	|:---	|:---	|:------------------	|:-------------------	|:---	|:---------------	|:---	|:-------	|
| CSP   	|   	| global-opco 	|   	| short_app_name 	|   	|   	| dv/pr/pp  	| environment_index 	|   	| location_code (location) 	|   	| index (fixed 01)	|
| `z`     	| - 	| `ago`         	| - 	| `demo`           	| - 	|   	| `dv`               	| `01`                	| - 	| `en1`           	| - 	| `01`    	|

##
## <font color="red"><b>Authenticating with Azure</b></font>

---
> NOTE:
> Once completed hook up TFE to this GitHub organization and within a TFE workspace set the variables for deployment as such:
##
| Variable            	| Description                 	| Mandatory 	| Validation 	| Example                              	|
|:---------------------	|:-----------------------------	|:-----------	|:------------	|--------------------------------------	|
| ARM_SUBSCRIPTION_ID 	| Subscription GUID           	| TRUE      	|Environment Variable            	| 00000000-0000-0000-0000-000000000000 	|
| ARM_CLIENT_ID       	| Application (client) ID     	| TRUE      	|Environment Variable            	| 00000000-0000-0000-0000-000000000000 	|
| ARM_TENANT_ID       	| Tenant GUID                 	| TRUE      	|Environment Variable       	| 00000000-0000-0000-0000-000000000000 	|
| ARM_CLIENT_SECRET   	| Application (client) Secret 	| TRUE      	|Sensitive Environment Variable           	| *********************                	|
<img src="https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/blob/master/tfe.PNG?raw=TRUE" alt="Terraform Enterprise"/>