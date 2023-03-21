output "resource_group_template_deployment_id" {
  description = "The ID of the Resource Group Template Deployment."
  value       = azurerm_resource_group_template_deployment.run-validation.id
}

output "resource_group_template_deployment_output_content" {
  description = "The JSON Content of the Outputs of the ARM Template Deployment."
  value       = azurerm_resource_group_template_deployment.run-validation.output_content
}