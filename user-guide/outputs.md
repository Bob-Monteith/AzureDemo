[<< Back to Readme](../README.md)

[<< Back to User Guide](../)

[Get Support](https://confluence.axa.com/confluence/x/L49iDw)
##
## <font color="red"><b>Getting help using outputs</b></font>

```go
## Accessing outputs when using foreach virtual machine
output "for_each_azurerm_virtual_network_name" {
  value = {
    for k, vm in module.terraform-azure-vm : k => vm.azurerm_virtual_network_name
  }
}
```

```go
## Accessing outputs for a single virtual machine
output "azurerm_virtual_network_name" {
  value = module.terraform-azure-vm.azurerm_virtual_network_name
}
```