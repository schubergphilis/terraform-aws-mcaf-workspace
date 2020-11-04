locals {
  connect_vcs_repo = var.connect_vcs_repo ? { create = true } : {}
}
module "workspace_account" {
  providers   = { aws = aws }
  source      = "github.com/schubergphilis/terraform-aws-mcaf-user?ref=v0.1.6"
  name        = var.username
  policy      = var.policy
  policy_arns = var.policy_arns
  tags        = var.tags
}

module "github_repository" {
  count                  = var.create_repository ? 1 : 0
  source                 = "github.com/schubergphilis/terraform-github-mcaf-repository?ref=v0.3.0"
  admins                 = var.github_admins
  branch_protection      = var.branch_protection
  delete_branch_on_merge = var.delete_branch_on_merge
  description            = var.repository_description
  name                   = var.github_repository
  readers                = var.github_readers
  visibility             = var.repository_visibility
  writers                = var.github_writers
}

resource "github_repository_file" "default" {
  count      = var.create_backend_config ? 1 : 0
  repository = var.github_repository
  file       = "${var.working_directory}/backend.tf"
  branch     = var.branch

  content = templatefile("${path.module}/backend.tf.tpl", {
    organization = var.terraform_organization
    workspace    = var.name
  })

  depends_on = [module.github_repository]
}

resource "tfe_workspace" "default" {
  name                  = var.name
  organization          = var.terraform_organization
  auto_apply            = var.auto_apply
  file_triggers_enabled = var.file_triggers_enabled
  ssh_key_id            = var.ssh_key_id
  terraform_version     = var.terraform_version
  trigger_prefixes      = var.trigger_prefixes
  queue_all_runs        = true
  working_directory     = var.working_directory

  dynamic vcs_repo {
    for_each = local.connect_vcs_repo

    content {
      identifier         = "${var.github_organization}/${var.github_repository}"
      branch             = var.branch
      ingress_submodules = false
      oauth_token_id     = var.oauth_token_id
    }
  }
}

resource "tfe_notification_configuration" "default" {
  count            = var.slack_notification_url != null ? 1 : 0
  name             = tfe_workspace.default.name
  destination_type = "slack"
  enabled          = length(coalesce(var.slack_notification_triggers, [])) > 0
  triggers         = var.slack_notification_triggers
  url              = var.slack_notification_url
  workspace_id     = tfe_workspace.default.external_id
}

resource "tfe_variable" "aws_access_key_id" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = module.workspace_account.access_key_id
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "aws_secret_access_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = module.workspace_account.secret_access_key
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "aws_default_region" {
  key          = "AWS_DEFAULT_REGION"
  value        = var.region
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "clear_text_env_variables" {
  for_each = var.clear_text_env_variables

  key          = each.key
  value        = each.value
  category     = "env"
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "sensitive_env_variables" {
  for_each = var.sensitive_env_variables

  key          = each.key
  value        = each.value
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "clear_text_terraform_variables" {
  for_each = var.clear_text_terraform_variables

  key          = each.key
  value        = each.value
  category     = "terraform"
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "sensitive_terraform_variables" {
  for_each = var.sensitive_terraform_variables

  key          = each.key
  value        = each.value
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}
