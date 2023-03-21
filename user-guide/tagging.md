||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
## <font color="red"><b>Tagging your Virtual Machine</b></font>

---

| Variable            	| Description                                                                                             	| Mandatory 	| Validation | Example                                                              	|                        	|
|:---------------------	|:---------------------------------------------------------------------------------------------------------	|:-----------	|:-----------------------------------------------------------------------------------	|:------------------------|:------------------------|
| global-opco         	| **SET2**: Validated to be 3 characters and this is the entity trigram                                   	| Yes      	| 3 chars e.g. `ago`                                                                  |                        	|
| global-env          	| Used to work out the resource names and network also a mandatory tag                                    	| Yes      	| `development` `production` `pre-production` `integration`                         	|                        	|
| global-app          	| Used for tagging of the resources and identification of the resource group                              	| Yes      	| e.g. Test Application                                                               |                        	|
| global-dcs          	| OPCO BU owning the Subscription/Account/Project                                                         	| Yes      	| e.g. Cloud Products                                                                 |                        	|
| global-cbp          	| Validated to be a cloud building permit in the format A00000                                            	| Yes      	| A and 5 digits e.g. A12345                                                          |                        	|
| global-appserviceid 	| SILVA SysID                                                                                             	| Yes      	| GUID `00000000000000000000000000000000`                                           	|                        	|
| global-project      	| Project acronym, cost center Activity code                                                              	| Yes      	|                                                                                   	|                        	|
| TFC_WORKSPACE_SLUG  	| organization and project information from at least `GitHub` `DevOps` `TFE` passed through from runtime to module 	| Yes     	| `System.TeamFoundationCollectionUri/System.TeamProject` (The URI of the TFS collection or Azure DevOps organization and The name of the project that contains this build.	) `var.TFC_WORKSPACE_SLUG` (The full slug of the configuration used in this run. This consists of the organization name and workspace name) `$GITHUB_WORKSPACE` (The default working directory on the runner for steps, and the default location of your repository) 	| `var.TFC_WORKSPACE_SLUG` 	|
| TFC_RUN_ID  	| run information from at least `GitHub` `DevOps` `TFE` passed through from runtime to module 	| Yes     	| `System.TimelineId` (A string-based identifier for the execution details and logs of a single pipeline run.	) `var.TFC_RUN_ID` (A unique identifier for this run.	) `$GITHUB_RUN_ID` ( unique number for each workflow run within a repository.) 	| `var.TFC_RUN_ID` 	|
| puppetbranch        	| Custom branch of the server in Puppet                                                                   	| No     	|                                                                                   	| `null`                 	|
| custom_tags         	| A list of additional custom tags in the following format:                                               	| No     	|                                                                                   	| `[]`                  	|
### custom_tags
A list of additional custom tags in the following format:
>NOTE: Optional add variable "custom_tags" {} to variables.tf and add custom_tags = var.custom_tags to module block
```go
custom_tags = {
  "local-whatisthis"         = "something"
  "local-yourtag"            = "tagvalue"
}
```

##
## <font color="red"><b>Other Tags used on the Virtual Machine</b></font>
> NOTE: Provisioniong flow information https://confluence.axa.com/confluence/x/pSrIEg
---

| Variable            	| Description| Purpose 	| Tag | From |                        	|
|:---------------------	|:---------------------------------------------------------------------------------------------------------	|:-----------	|:-----------------------------------------------------------------------------------	|:------------------------|:------------------------|
| exposure         	| The exposure of the virtual machine | Sent to orchestration | `local-configuration`| `var.exposure` |
| routable         	| The routability of the virtual machine always true (hostoric) | Sent to orchestration | `local-configuration`| `true`|
| availability_zone | Specifies the zones to be used for this Virtual Machine | Sent to orchestration | `local-configuration`| `var.availability_zones` |
| axavmrole         | Role of the server in Puppet | Sent to orchestration | `local-configuration`| `var.axavmrole`|
| puppetbranch      | Custom branch of the server in Puppet | Used for specific puppet branch use | `local-configuration`| `var.puppetbranch`|
| data_disks        | count of data disks | Info only | `local-configuration`| default disks and `additional_disk_configuration`|
| data_disksize     | custom disk size | Info only | `local-configuration`| `var.data_disk_size`|
| workspace_slug    | where the deployment comes from | Info only | `local-deployment`| `var.TFC_WORKSPACE_SLUG`|
| moduleversion     | Which version of the module created this | Info only | `local-deployment`| `x.x.x`|
| local-purpose     | Identitfy MPI vm for reporting | Reporting |  Own tag| `MPI`|
| local-vmostype    | Which OS is this Virtual machine | Sent to orchestration |  Own tag| `var.os_type`|
| local-vmdrclass          | Which DR class used | Sent to orchestration | Own tag | `x.x.x`|
| local-vmbackuppolicy     | Which backup policy | Sent to orchestration | Own tag | `var.dr_serviceclass`|
| local-vmbackupvault      | Which vault used for backup | Info only | Own tag | `x.x.x`|
| local-backupresource     | Which other vault used for backing up data | Used for fileshare mounting and SQL config | Own tag | `x.x.x`|
| local-vmsupportrg        | Support resource group | Used to identify support components | Own tag | `var.support_resource_group`|
| local-licensetype        | Hybrid benefit of Windows_Server or RHEL_BYOS | Sent to orchestration | Own tag | Hybrid Benefit|
| local-vmsource           | Which type of virtual machine | Sent to orchestration | Own tag | Rehosted or New|
| local-vmstatus           | Starts with a value of NotReady used to update result| Custom provisioning | Own tag | `var.orchestration`|
| local-vmfqdn             | Will be the hostname.domain of the VM post activity2-hostname | Custom provisioning | Own tag | `var.orchestration`|
| local-vmprovisioning     | Updated with current ActivityName.Status | Custom provisioning | Own tag | `var.orchestration`|
| local-vmpuppetstatus     | When activity4-puppetcheck sees the status changed will be updated to succeeded or failed | Custom provisioning | Own tag | `var.orchestration`|
| local-vmprovisioningid   | Unique id for a virtual machine flow | Custom provisioning | Own tag | `var.orchestration`|
| local-workspace_runid    | Used to identify the first run for Silva | Sent to orchestration | Own tag | `var.TFC_RUN_ID`|