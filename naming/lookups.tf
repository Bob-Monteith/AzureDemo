locals {
  region_data              = jsondecode(file("${path.module}/lookups/regions.json"))
  timezone_data            = jsondecode(file("${path.module}/lookups/timezones.json"))
  environment_data         = jsondecode(file("${path.module}/lookups/environments.json"))
  serviceid_data           = jsondecode(file("${path.module}/lookups/serviceids.json"))
  location_code            = [for x in local.region_data.regions : x if x.region == var.location][0].code
  environment_code         = [for x in local.environment_data.environments : x if x.environment == lower(var.global-env)][0].code
  network_environment_code = [for x in local.environment_data.networks : x if x.environment == lower(var.global-env)][0].code
  timezone                 = [for x in local.timezone_data.timezones : x if x.region == var.location][0].zone
  techserviceid            = [for x in local.serviceid_data.techserviceids : x if x.region == var.location][0].technical_service_id
}