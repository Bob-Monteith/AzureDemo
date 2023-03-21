||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Re-hosting your Virtual Machine</b></font>

---

By default this module creates a Windows or a Linux machine with disks and a network interface however you can also use it build a VM based on snapshots in the same subscription. This then allows the new VM  to use the services the support module provides. To do this ensure you match the normal module declaration and add the following migration variables.
> NOTE: You need to either create the resource group manually or declare it in the main.tf but it must match the naming convention and you must deploy the support module before you deploy VMs this resource group must end with -asr.
> NOTE: Check the permissions required https://confluence.axa.com/confluence/x/cpfFDg
> NOTE: Resource group needs creating manually with -asr
### Preconditions
> NOTE: Configuration adheres to some prerequisites you will be blocked if you try to deploy a Virtual machine under the following
- Must use reserve_capacity for Production and DR Gold.
- Must use DR service class when migrating.
- Must use availability zones when migrating.
- image_template cannot be used when migrating.- 
####
---

| Variable                      	| Description                               	| Mandatory 	| Validation                	    | Default 	|
|:-------------------------------	|:-------------------------------------------	|:-----------	|:---------------------------	    |:---------	|
| migration                     	| Is this a migrated Virtual Machine        	| No     	| `true` `false`            	    | `false` 	|
| migration_resource_group      	| Resource group where the snapshots are    	| No      	| e.g. `z-ago-snaps-dv01-ew1-01` 	| `null`   	|
| migration_os_snapshot_name    	| Name of the OS snapshot                   	| No      	| e.g. `DAGA00AA-OSDisk-01`      	| `null`   	|
| migration_data_snapshot_names 	| A list of additional data disks snapshots 	| No     	| See example               	    | `null`   	|

### Snapshot Disk configuration
####
>NOTE: Optional add variable "migration_data_snapshot_names" {} to variables.tf and add migration_data_snapshot_names = var.migration_data_snapshot_names to module block
#
These can be overridden in your terraform.auto.tfvars file
```go
migration_data_snapshot_names = [
    {
      name = "DAGA00AA-DATADisk-01"
    },
    {
      name = "DAGA00AA-DATADisk-02"
    }    
  ]
```
####

---
[See examples](../examples.md)