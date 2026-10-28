output "state_demo" {
  description = "Marker stored in the remote Terraform state."
  value       = terraform_data.state_demo.output
}
