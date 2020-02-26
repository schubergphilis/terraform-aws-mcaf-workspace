output "repo_full_name" {
  value       = var.create_repository ? module.github_repository.full_name : null
  description = "The full 'organization/repository' name of the repository"
}

output "workspace_id" {
  value       = tfe_workspace.default.id
  description = "The Terraform workspace ID"
}
