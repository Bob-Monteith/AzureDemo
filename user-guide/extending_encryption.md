# Quickstart: Use application specific encryption deployed as a sub module of the MPI support module.
||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
Article tested with the following Terraform and Terraform provider versions:

- [Terraform v1.3.7](https://releases.hashicorp.com/terraform/)
- [AzureRM Provider v.3.46.0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AzAPI Provider v.1.4.0](https://registry.terraform.io/providers/azure/azapi/latest/docs)

In this article, you learn how to use this module to associate a existing keyvault for your application disks.

> * Deploy encryption feature using the support sub module to a dedicated resource group
> * Deploy virtual machine to consume the encryption keyvault using the variables below

## Prerequisites

 Resource group needs creating manually in the following format for encryption of your virtual machine
####
| SET1||**SET2**||**SET3**|||**SET4**|**SET5**||**SET6**||**SET7**|
|:-------|:---|:-------------|:---|:----------------|:---|:---|:------------------|:-------------------|:---|:---------------|:---|:-------|
|CSP||global-opco||application_name|||dv/pr/pp|environment_index||location_code(location)||index(fixed01)|
|`z`|-|`ago`|-|`demo`|-||`dv`|`01`|-|`en1`|-|`01`|

## Required variables
 The following values in the `app_centric` variable will force the virtual machine to use the specific encryption Key Vault.
| Values|Description|Mandatory|Validation/Example|Default|
|:-------------------------------------------|:-----------------------------------------------------------------------|:-----------|--------------------------|:---------|
|encryption_resource_group_name|Additional resource group where encryption components are.|No| See app_centric below example| `null`|
|encryption_vault_name |Additional Azure Key Vault to be used for this machines disk encryption.|No|See app_centric below example|`null`|

## App centric
```go
app_centric = {
    encryption_vault_name          = "zagoappadv01en1key51"
    encryption_resource_group_name = "z-ago-support-dv07-en1-01"
}
```

## Verify the results

- Check the virtual machine disks encryption set is using the dedicated Key Vault.

**Key points:**

---

## Clean up resources

## Troubleshoot Terraform on Azure

## Next steps
