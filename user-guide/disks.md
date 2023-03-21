||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Changing your Virtual Machine disk configuration</b></font>

---
> NOTE: Check the permissions required https://confluence.axa.com/confluence/x/cpfFDg

| Variable                      	| Description                                                                        	| Mandatory 	| Validation                                                                     	| Default           	|
|:-------------------------------	|:------------------------------------------------------------------------------------	|:-----------	|:--------------------------------------------------------------------------------	|:-------------------	|
| os_disk_size_gb                	| The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.                                                      	| No     	| Valid 2 or 3 digit number                                                      	| null              	|
| data_disk_size                	| Size of the default data disk                                                      	| No     	| 1-32767                                                      	| `35`              	|
| hyper_v_generation            	| The HyperV Generation of the Disk used for re-hosting                              	| No     	| `V1` `V2`                                                                      	| `V1`              	|
| encryption                    	| Should all data disks be encrypted using customer-managed key must give SPN key_permissions "Get","Create","List","Delete"                     	| No     	| `true` `false`                                                                 	| `false`           	|
| vm_storage_account_type       	| Specifies the type of Storage Account which should back this the Internal OS Disk. 	| No     	| `Standard_LRS` `StandardSSD_LRS` `Premium_LRS`                                 	| `StandardSSD_LRS` 	|
| disk_storage_account_type     	| Specifies the The type of storage to use for the managed disks.                    	| No     	| `Standard_LRS` `StandardSSD_ZRS` `Premium_LRS` `Premium_ZRS` `StandardSSD_LRS` 	| `StandardSSD_LRS` 	|
| data_disk_caching     	| Specifies the The type of disk caching for premium storage can be updated on existing disks.                    	| No     	| `None` `ReadOnly` `ReadWrite`	| `None` 	|
| additional_disk_configuration 	| A list of additional data disks added to AXA role server standards                 	| No     	| See example                                                                    	| Example below     	|



### Disk configuration defaults
####
>NOTE: Disk Names only numbers, letters, hyphens, and underscores are allowed. In addition, the value cannot end with an underscore and must also be less than 80 characters long.
#
These can be overridden in your terraform.auto.tfvars file
```go
additional_disk_configuration = [
    {
      name = "AnotherData"
      size = 10
  }]
```
####
>NOTE: Optional add variable "data_disks" {} to variables flle and add additional_disk_configuration = var.data_disks to module block