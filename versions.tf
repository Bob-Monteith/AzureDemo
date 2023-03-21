terraform {
  required_providers {
    # https://github.com/hashicorp/terraform-provider-azurerm/releases
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.46.0"
    }
    # https://github.com/Azure/terraform-provider-azapi/releases
    azapi = {
      source  = "Azure/azapi"
      version = ">=1.4.0"
    }
    # https://github.com/hashicorp/terraform-provider-random/releases
    random = {
      source  = "hashicorp/random"
      version = ">=3.4.3"
    }
    # https://github.com/hashicorp/terraform-provider-time/releases
    time = {
      source  = "hashicorp/time"
      version = ">=0.9.1"
    }
  }
  required_version = ">=1.3.7"
}