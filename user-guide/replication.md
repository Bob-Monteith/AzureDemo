||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Replicating your Virtual Machine</b></font>

---
> **NOTE**:
> Resource group needs creating manually in the following format for replicating your virtual machine
####
####
| SET1 	|   	| **SET2**       	|   	| **SET3**          	|   	|   	| **SET4**            	| **SET5**             	|   	| **SET6**         	|   	| **SET7** 	|  **SET8** 	|
|:-------	|:---	|:-------------	|:---	|:----------------	|:---	|:---	|:------------------	|:-------------------	|:---	|:---------------	|:---	|:-------	|:-------	|
| CSP   	|   	| global-opco 	|   	| short_app_name 	|   	|   	| dv/pr/pp  	| environment_index 	|   	| location_code (location) 	|   	| index (fixed 01)	| asr |
| `z`     	| - 	| `ago`         	| - 	| `demo`           	| - 	|   	| `dv`               	| `01`                	| - 	| `en1`           	| - 	| `01`    	| `-asr`

##
### Precondtions
> NOTE: Configuration adheres to some prerequisites you will be blocked if you try to deploy a Virtual machine under the following
- Must use availability zones when migrating
- Must use a valid static IP

### Variables
| Variable                                  	| Description                                                           	| Mandatory 	| Validation / Example     	| Default 	|
|:-------------------------------------------	|:-----------------------------------------------------------------------	|:-----------	|--------------------------	|:---------	|
| dr_serviceclass                 	            | Used to update Silva with the DR service class and apply DR, Bronze makes disks zonal only, Gold configures DR | FALSE     	| `none` `bronze` `gold` `platinum`  	| `none`                	|