# Release Tests
All notable tests on latest module release will be documented in this file.
```
____   _________                       .___    .__
\   \ /   /     \     _____   ____   __| _/_ __|  |   ____
 \   Y   /  \ /  \   /     \ /  _ \ / __ |  |  \  | _/ __ \
  \     /    Y    \ |  Y Y  (  <_> ) /_/ |  |  /  |_\  ___/
   \___/\____|__  / |__|_|  /\____/\____ |____/|____/\___  >
                \/        \/            \/               \/


```
### [version:2.15.0](https://github.axa.com/ago-sharedtferegistry/terraform-azure-vm/tree/2.15.0) - (2023-03-14)
### [MPI Release v1.14.0](https://confluence.axa.com/confluence/x/x7GZF)
- Test you can specify extended encryption from support module using encryption_resource_group_name and encryption_vault_name
- Check you can deploy to southeastasia
- Check new tag using new var notification_email on machine.
- Check new tag using new var silva_internal_id on machine.
- Check you can create larger disks
- Check pre-condition stops larger disks with ReadWrite as none supported disk sku
- Check Data Collection rules are updated ok without any lock issue.
- Check Global Data Collection rules are by default off unless pre-prod pr production or you specify global-monitoring.
- Check disks now have Disable public and private on Networking.
- Check disks count is accurate on tags when adding additional disks.
