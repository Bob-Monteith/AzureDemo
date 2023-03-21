||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Secret Virtual Machines</b></font>

---
### Preconditions
> NOTE: Configuration adheres to some prerequisites you will be blocked if you try to deploy a Virtual machine under the following
- Must have a secret subnet this is identified as main-s-rt.
- Must enable encryption on secret virtual machines using var.encryption.
- Must provide var.fileshare_resource_group_name and var.fileshare_storage_account_name for fileshare and have deployed this extension before trying to use secret.

| Variable                      	| Description                                                                        	| Mandatory 	| Validation                                                                     	| Default           	|
|:-------------------------------	|:------------------------------------------------------------------------------------	|:-----------	|:--------------------------------------------------------------------------------	|:-------------------	|
| encryption                    	| Should all data disks be encrypted using customer-managed key must give SPN key_permissions "Get","Create","List","Delete"                     	| No     	| `true` `false`    |
| global-dataclass              	| Used to determine network to join must be secret                                                                                                                     	| Yes      	| `public` `confidential` `internal` `secret`	| `secret`   	|