output "arn" {
  value       = module.workspace_account.arn
  description = "The workspace user ARN"
}

output "workspace_id" {
  value       = tfe_workspace.default.id
  description = "The Terraform Cloud workspace ID"
}
