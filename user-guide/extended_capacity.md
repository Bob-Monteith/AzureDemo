# Quickstart: Use application specific capacity deployed as a sub module of the MPI support module.
||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
Article tested with the following Terraform and Terraform provider versions:

- [Terraform v1.3.7](https://releases.hashicorp.com/terraform/)
- [AzureRM Provider v.3.46.0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AzAPI Provider v.1.4.0](https://registry.terraform.io/providers/azure/azapi/latest/docs)

In this article, you learn how to use this module to associate a dedicated capacity group for your application.

> * Deploy capacity group feature using the support sub module to a dedicated resource group
> * Deploy virtual machine to consume the capacity group  using the variables below

## Prerequisites

 Resource group needs creating manually in the following format for fileshare for your virtual machine
####
| SET1||**SET2**||**SET3**|||**SET4**|**SET5**||**SET6**||**SET7**|
|:-------|:---|:-------------|:---|:----------------|:---|:---|:------------------|:-------------------|:---|:---------------|:---|:-------|
|CSP||global-opco||application_name|||dv/pr/pp|environment_index||location_code(location)||index(fixed01)|
|`z`|-|`ago`|-|`demo`|-||`dv`|`01`|-|`en1`|-|`01`|

## Required variables

> The `reserve_capacity` variable should be set to true to use the capacity group

 The following values in the `app_centric` variable will force the virtual machine to use the specific capacity group.
| Values|Description|Mandatory|Validation/Example|Default|
|:-------------------------------------------|:-----------------------------------------------------------------------|:-----------|--------------------------|:---------|
|capacity_resource_group_name|Additional resource group where capacity components are.|No| See app_centric below example| `null`|
|capacity_group_name |Additional capacity group to be used for this machine.|No|See app_centric below example|`null`|

## App centric
```go
app_centric = {
    capacity_group_name          = "zagoappadv01en1crg91"
    capacity_resource_group_name = "z-ago-appa-dv05-en1-01"
}
```

## Verify the results

- Check the capacity has been allocated in the capacity reservation group for the VM size in use..

**Key points:**

---

## Clean up resources

## Troubleshoot Terraform on Azure

## Next steps
