output "repo_full_name" {
  value       = var.create_repository ? module.github_repository.full_name : null
  description = "The full 'organization/repository' name of the repository"
}

output "workspace_id" {
  value       = tfe_workspace.default.id
  description = "The Terraform workspace ID"
}

output "access_key_id" {
  value       = var.aws_credentials == null ? module.workspace_account[0].access_key_id : var.aws_credentials.access_key_id
  description = "The AWS Access Key ID used by the workspace"
  sensitive   = true
}

output "secret_access_key" {
  value       = var.aws_credentials == null ? module.workspace_account[0].secret_access_key : var.aws_credentials.secret_access_key
  description = "The AWS Secret Access Key used by the workspace"
  sensitive   = true
}
