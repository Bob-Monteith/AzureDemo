module "support_names" {
  source            = ".//naming"
  environment_index = substr(var.support_resource_group, 16, 2)
  application_name  = "support"
  location          = var.location
  global-env        = lower(substr(var.support_resource_group, 14, 2)) == "pr" ? "Production" : lower(substr(var.support_resource_group, 14, 2)) == "pp" ? "Pre-Production" : "Development"
  global-opco       = var.global-opco
}

module "gallery_names" {
  source            = ".//naming"
  environment_index = var.gallery_environment_index
  application_name  = "shigal"
  location          = "northeurope"
  global-env        = data.azurerm_client_config.current.tenant_id == "d65b03ed-6a7d-41ca-a17d-4798d70d1d3f" ? "Development" : "Production"
  global-opco       = "ago"
}

module "group_names" {
  source            = ".//naming"
  environment_index = var.environment_index
  application_name  = var.resource_group_app_name == "none" ? format("%s", var.short_app_name) : lower(var.resource_group_app_name)
  location          = var.location
  global-env        = var.global-env
  global-opco       = var.global-opco
}


module "machine_names" {
  source            = ".//naming"
  environment_index = var.environment_index
  application_name  = format("%s%s", var.short_app_name, var.vm_name)
  location          = var.location
  global-env        = var.global-env
  global-opco       = var.global-opco
}

module "network_names" {
  source            = ".//naming"
  environment_index = var.network_environment_index
  application_name  = var.network_app_spoke_name != null ? var.network_app_spoke_name : "${lower(var.subnet_exposure) == "internal" ? "int" : lower(var.subnet_exposure) == "management" ? "mgt" : "ext"}spk"
  location          = var.location
  global-env        = var.global-env
  global-opco       = var.global-opco
}