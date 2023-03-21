# Quickstart: Use application specific fileshare deployed as a sub module of the MPI support module.
||||
|:--|:--|:--
|[Module Readme](../README.md)|[Module User Guide](../)|[Get Support](https://confluence.axa.com/confluence/x/L49iDw)|
##
Article tested with the following Terraform and Terraform provider versions:

- [Terraform v1.3.7](https://releases.hashicorp.com/terraform/)
- [AzureRM Provider v.3.46.0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AzAPI Provider v.1.4.0](https://registry.terraform.io/providers/azure/azapi/latest/docs)

In this article, you learn how to use this module to associate a file share in a dedicated storage acount for your application.

> * Deploy backup fileshare feature using the support sub module to a dedicated resource group
> * Deploy virtual machine to consume the storage account using the variables below

## Prerequisites

 Resource group needs creating manually in the following format for fileshare for your virtual machine
####
| SET1||**SET2**||**SET3**|||**SET4**|**SET5**||**SET6**||**SET7**|
|:-------|:---|:-------------|:---|:----------------|:---|:---|:------------------|:-------------------|:---|:---------------|:---|:-------|
|CSP||global-opco||application_name|||dv/pr/pp|environment_index||location_code(location)||index(fixed01)|
|`z`|-|`ago`|-|`demo`|-||`dv`|`01`|-|`en1`|-|`01`|

## Required variables
> The `axavmrole` variable should be set with one the following value to deploy the fileshare : `oracle` or `db2`

 The following values in the `app_centric` variable will force the file share to be created in your specific storage account.
| Values|Description|Mandatory|Validation/Example|Default|
|:-------------------------------------------|:-----------------------------------------------------------------------|:-----------|--------------------------|:---------|
|fileshare_resource_group_name|Additional resource group where fileshare components are.|No| See app_centric below example| `null`|
|fileshare_storage_account_name |Additional Storage account for fileshare.|No| See app_centric below example |`null`|
|fileshare_recovery_vault_name |Additional Recovery Vault account for fileshare.|No| See app_centric below example |`null`|

## App centric
```go
app_centric = {
    fileshare_recovery_vault_name = "zagopadv07en1rsv51"
    fileshare_resource_group_name = "z-ago-support-dv07-en1-01"
    fileshare_storage_account_name = "zagopadv07en1sto51"
}
```

## Verify the results

- Check the storage account file shares to ensure the new fileshare is created as expected.
- Check the fileshare is mounted and the readme is accessible from the VM https://confluence.axa.com/confluence/x/pSrIEg
- Check the file share is backed up with the corresponding ASR Backup Items (Azure Storage (Azure Files))


**Key points:**

- The virtual machine will be tagged with the fileshare resource group `local-backupsharerg` and storage account `local-backupshare`.
---

## Clean up resources

## Troubleshoot Terraform on Azure

## Next steps
