[<< Back to Readme](../README.md)

[<< Back to User Guide](../)

[Get Support](https://confluence.axa.com/confluence/x/L49iDw)
##
## <font color="red"><b>Backing up your Virtual Machine and Database</b></font>
### Preconditions
> NOTE: Configuration adheres to some prerequisites you will be blocked if you try to deploy a Virtual machine under the following
- DR Bronze must have a backup
- Production must have a backup
- None base machines must have a backup
> NOTE: Check the permissions required https://confluence.axa.com/confluence/x/cpfFDg

### Variables
| Variable         	| Description                                                                                                          	| Mandatory 	| Validation                                                	| Default 	|
|:------------------	|:----------------------------------------------------------------------------------------------------------------------	|:-----------	|:-----------------------------------------------------------	|:---------	|
| vm_backuppolicy  	| Sets the backup policy for this VM, you must have deployed the support module with which contains the recovery vault 	| No     	| `none` `light` `basic` `medium` `intermediate` `enhanced` 	| `none`  	|
| file_share_quota 	| The maximum size of the linux file share, in gigabytes                                                               	| No     	| Size in GB                                                	| `5120`  	|
| fileshare_resource_group_name 	| Application specific fileshare resource group deployed by support module                                                               	| No     	| name of resource group                                               	| `z-ago-myshares-dv05-en1-01`  	|
| fileshare_storage_account_name 	| Application specific fileshare deployed by support module                                                               	| No     	| name of storage account                                                	| `zagomysharesdv05en1sto78`  	|

### Backup policies
| Policy       	| Daily Incremental 	| Monthly  	| Time  	|
|:--------------	|:-------------------	|:----------	|:-------	|
| light        	| 15 Days           	| None     	| 21:00 regional time	|
| basic        	| 15 Days           	| None     	| 21:00 regional time 	|
| medium       	| 35 Days           	| None     	| 21:00 regional time 	|
| intermediate 	| 35 Days           	| None     	| 21:00 regional time 	|
| enhanced     	| 15 Days           	| 6 Months 	| 21:00 regional time 	|

####
>NOTE: Backup is enforced to basic in production environments if not set
>NOTE: You cannot change Backup policy and vault unless you stop and remove all backups on the current vault and deploy the virtual machine with a new backup policy.
