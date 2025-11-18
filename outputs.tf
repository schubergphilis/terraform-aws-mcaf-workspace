output "arn" {
  value       = try(module.workspace_iam_user[0].arn, "")
  description = "The workspace IAM user ARN"
}

output "workspace_name" {
  value       = module.tfe-workspace.name
  description = "The Terraform Cloud workspace name"
}

output "workspace_id" {
  value       = module.tfe-workspace.id
  description = "The Terraform Cloud workspace ID"
}
