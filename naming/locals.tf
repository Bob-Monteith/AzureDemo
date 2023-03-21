locals {
  #set1                = "z"
  #set2                = var.global-opco
  #set3                = var.application_name
  #set4                = local.environment_code
  #set5                = var.environment_index
  #set6                = local.location_code
  #set7                = Object Index
  resource_sets       = format("z%s%s%s%s%s", var.global-opco, var.application_name, local.environment_code, var.environment_index, local.location_code)
  machine_sets        = format("z%s%s%s%s", var.global-opco, var.application_name, local.environment_code, var.environment_index)
  network_sets        = format("z%s%s%s%s%s", var.global-opco, var.application_name, local.network_environment_code, var.environment_index, local.location_code)
  resource_group_sets = format("z-%s-%s-%s%s-%s-", var.global-opco, var.application_name, local.environment_code, var.environment_index, local.location_code)
  network_group_sets  = format("z-%s-%s-%s%s-%s-", var.global-opco, var.application_name, local.network_environment_code, var.environment_index, local.location_code)
}