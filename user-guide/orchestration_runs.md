[<< Back to Readme](../README.md)

[<< Back to User Guide](../)

[Get Support](https://confluence.axa.com/confluence/x/L49iDw)
##
## <font color="red"><b>Using orchestration to either do a dry_run or a re-run when not using normal terraform definition</b></font>
> NOTE: when using a normal terraform block only use `orchestration_dry_run` or `orchestration_re_run`
> NOTE: dry_run is used to call orchestration and test your vm rather than build it.
> 
> NOTE: re_run is used to replay the process of your vm through provitioning and orchestration.
### Variables
| Variable                    	| Description                                                                                                                                                                                         	| Mandatory 	| Validation                      	| Example                 	|
|:-----------------------------	|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|:-----------	|:---------------------------------	|:-------------------------	|
| orchestration       	| Feature testing payload. Do only use for testing purposes. Expected input {}                            	| No     	| {Something}                                                                       	| `{}`                   	|
| orchestration_dry_run              	| Used to test a deployment doesnt deploy a Virtual Machine but does call the orchestration platform templates                                                                                                     	| No      	|      `false` `true`                      	| `false`                        	|
| orchestration_re_run              	| Used to resume orchestration on a Virtual Machine                                                                                                      	| No      	|      `false` `true`                      	| `false`                        	|

## <font color="red"><b>Using orchestration to either do a dry_run or a re-run without using the vm module definition</b></font>

```go
module "orchestration_run" {
 source                 = "users.tfe-prod.aws-cloud.axa-de.intraxa/AGO-SharedModules/vm/azure//orchestration_run"
  mode                = "dry_run" # "re_run"
  resource_group_name = var.resource_group_name
  location            = var.location
  # tags
  global-opco         = var.global-opco
  global-dcs          = var.global-dcs
  global-env          = var.global-env
  global-dataclass    = var.global-dataclass
  global-cbp          = var.global-cbp
  global-project      = var.global-project
  global-app          = var.global-app
  global-appserviceid = var.global-appserviceid
  # machine
  virtual_machine_name = var.virtual_machine_name
  vmsource             = "New" # or Rehosted
  # network
  subnet_exposure    = var.subnet_exposure
  private_ip_address = var.private_ip_address
  # disks
  availability_zone = var.availability_zone
  # OS
  axavmrole   = var.axavmrole
  os_type     = var.os_type
  # backup and dr
  dr_serviceclass = var.dr_serviceclass
  vmbackuppolicy  = var.support_backup_policy
  # deployment
  workspace_slug  = var.TFC_WORKSPACE_SLUG
  workspace_runid = var.TFC_RUN_ID
}
```