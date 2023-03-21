||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
### <font color="red"><b>Joining your Virtual Machine to a network</b></font>

---
> NOTE: Check the permissions required https://confluence.axa.com/confluence/x/cpfFDg
> NOTE: Spoke identification uses the format and requires that Resource Group and Virtual Network use the same SET information.
### Preconditions
> NOTE: Configuration adheres to some prerequisites you will be blocked if you try to deploy a Virtual machine under the following
- Using DR Bronze or Gold requires a static IP
####
| SET1 	    |   	| **SET2**       	|   	| **SET3**          	                    |   	|   	| **SET4**            	| **SET5**             	        |   	| **SET6**         	|   	| **SET7** 	            |
|:-------	|:---	|:-------------	    |:---	|:----------------	                        |:---	|:---	|:------------------	|:-------------------	        |:---	|:---------------	|:---	|:-------	            |
| CSP   	|   	| global-opco 	    |   	| subnet_exposure/network_app_spoke_name 	|   	|   	| global-env  	        | network_environment_index 	|   	| location_code 	|   	| network_object_index	|
| `z`     	| - 	| `ago`         	| - 	| `intspk`           	                    | - 	|   	| `dv`               	| `01`                	        | - 	| `en1`           	| - 	| `01`    	            |
| `z`     	| - 	| `ago`         	| - 	| `extspk`           	                    | - 	|   	| `pp`               	| `02`                	        | - 	| `en1`           	| - 	| `01`                  |
| `z`     	| - 	| `ago`         	| - 	| `mgtspk`           	                    | - 	|   	| `pr`               	| `03`                	        | - 	| `en1`           	| - 	| `01`                  |
> NOTE: Subnet identification uses the format
####
| PART1 	|  |PART2 	| |PART3 	|
|:------|:---|:------|:---|:------ 	|
| subnet_project |  | subnet_exposure & global-dataclass 	|  	|rt
| `main`   |-   	| `pic`| - 	| `rt` |
| `main`   |-   	| `pi`| - 	| `rt` |
| `main`   |-   	| `c`| - 	| `rt` |
### Variables
| Variable                      	| Description                                                                                                                                           	| Mandatory 	| Validation                         	| Default    	|
|:-------------------------------	|:-------------------------------------------------------------------------------------------------------------------------------------------------------	|:-----------	|:------------------------------------	|:------------	|
| global-dataclass              	| Used to determine network to join                                                                                                                     	| Yes      	| `public` `confidential` `internal` `secret`	| `public`   	|
| subnet_exposure               	| Used to determine network to join                                                                                                                     	| Yes      	| `internal` `external` `management` 	| `internal` 	|
| subnet_project                	| Defaulted to main maybe used for additional subnets in the future                                                                                     	| No     	| `main`                             	| `main`     	|
| private_ip_address            	| The IP is Dynamic this can be overridden which then sets the VM to use this static IP                                                                 	| No     	| 0.0.0.0                            	| `0.0.0.0`  	|
| network_environment_index     	| **SET4**: Network environment Index in the format of (01-99) defaults to 01 this is not the same as environment_index and caters for multiple spokes. 	| No     	| 01-99                              	| `01`       	|
| network_object_index          	| **SET7**: Network unique object Index in the format of (01-99) defaults to 01                                                                         	| No     	| 01-99                              	| `01`       	|
| network_app_spoke_name        	| **SET3**: Optional application spoke name this must match the SET 3 of the of the resource group                                                      	| No     	|                                    	| `null`       	|
| accelerated_networking        	| Should Accelerated Networking be enabled? vm size needs to be supported and cannot be added to an existing machine.                                                       	| No     	|    `true` `false` | `false`


> NOTE: if you wanted to use all Static IPs you can simply convert your subnets into IP lists and allocate an index aligned to the object to reference the IP list e.g. var.iplist[2] where iplist = ["x.x.x.4","x.x.x.5","x.x.x.6"] However Azure reserves 5 IP addresses within each subnet. These are x.x.x.0-x.x.x.3 and the last address of the subnet.

> NOTE: to quickly find an available Address you can use this with any ip address within your subnet
```ps
az login --tenant $tenantid
az account set --s $subscriptionid
az network vnet check-ip-address --resource-group $rgroup --name $vnet --ip-address $anyip
```
### <font color="red"><b>Reserve a Static IP Address before deployment</b></font>
To reserve a static IP you can create a nic in a resource group either of which contains the name `ipreserve` this will stop any provisioning then when you want to use it destory the nic and deploy your terrafor,
### <font color="red"><b>Changing your Virtual Machine to a Static IP Address</b></font>
To switch from a dynamic IP to a static one you can perform the following steps:
1. Add custom tag so that the change to the nic does not try to re-provision the virtual machine ```custom_tags = {"local-vmprovignore" = true}     ```
2. Manually update the network interface in Azure to have a static IP Address Assignment by clicking Network Interface > IP configurations > IP > Assignment > Static > Save
3. Add private_ip_address to your Terraform code for this virtual machine
4. Deploy virtual machine check plan does not adjust or make any change.
