locals {
  connect_vcs_repo = var.repository_identifier != null ? { create = true } : {}
  enable_oidc      = var.auth_method == "iam_role_oidc" && var.oidc_settings != null
}

################################################################################
# Workspace
################################################################################

resource "tfe_workspace" "default" {
  name                      = var.name
  agent_pool_id             = var.agent_pool_id
  auto_apply                = var.auto_apply
  execution_mode            = var.execution_mode
  file_triggers_enabled     = var.file_triggers_enabled
  global_remote_state       = var.global_remote_state
  organization              = var.terraform_organization
  project_id                = var.project_id
  queue_all_runs            = true
  remote_state_consumer_ids = var.remote_state_consumer_ids
  ssh_key_id                = var.ssh_key_id
  tag_names                 = var.workspace_tags
  terraform_version         = var.terraform_version
  trigger_prefixes          = var.trigger_prefixes
  working_directory         = var.working_directory

  dynamic "vcs_repo" {
    for_each = local.connect_vcs_repo

    content {
      identifier         = var.repository_identifier
      branch             = var.branch
      ingress_submodules = false
      oauth_token_id     = var.oauth_token_id
    }
  }
}

resource "tfe_notification_configuration" "default" {
  count = var.slack_notification_url != null ? 1 : 0

  name             = tfe_workspace.default.name
  destination_type = "slack"
  enabled          = length(coalesce(var.slack_notification_triggers, [])) > 0
  triggers         = var.slack_notification_triggers
  url              = var.slack_notification_url
  workspace_id     = tfe_workspace.default.id
}

resource "tfe_variable" "aws_default_region" {
  key          = "AWS_DEFAULT_REGION"
  value        = var.region
  category     = "env"
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

resource "tfe_variable" "clear_text_hcl_variables" {
  for_each = var.clear_text_hcl_variables

  key          = each.key
  value        = each.value
  category     = "terraform"
  hcl          = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "sensitive_hcl_variables" {
  for_each = var.sensitive_hcl_variables

  key          = each.key
  value        = each.value.sensitive
  category     = "terraform"
  hcl          = true
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

################################################################################
# RBAC
################################################################################

data "tfe_team" "default" {
  for_each = toset(keys(var.team_access))

  name         = each.value
  organization = var.terraform_organization
}

resource "tfe_team_access" "default" {
  for_each = var.team_access

  access       = each.value.access
  team_id      = data.tfe_team.default[each.key].id
  workspace_id = tfe_workspace.default.id

  dynamic "permissions" {
    for_each = each.value.permissions != null ? { create = true } : {}

    content {
      run_tasks         = each.value.permissions["run_tasks"]
      runs              = each.value.permissions["runs"]
      sentinel_mocks    = each.value.permissions["sentinel_mocks"]
      state_versions    = each.value.permissions["state_versions"]
      variables         = each.value.permissions["variables"]
      workspace_locking = each.value.permissions["workspace_locking"]
    }
  }
}

################################################################################
# Auth - IAM User
################################################################################

module "workspace_iam_user" {
  count  = var.auth_method == "iam_user" ? 1 : 0
  source = "github.com/schubergphilis/terraform-aws-mcaf-user?ref=v0.4.0"

  name                 = var.username
  path                 = var.path
  policy               = var.policy
  policy_arns          = var.policy_arns
  permissions_boundary = var.permissions_boundary_arn
  tags                 = var.tags
}

resource "tfe_variable" "aws_access_key_id" {
  count = var.auth_method == "iam_user" ? 1 : 0

  key          = "AWS_ACCESS_KEY_ID"
  value        = module.workspace_iam_user[0].access_key_id
  category     = "env"
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "aws_secret_access_key" {
  count = var.auth_method == "iam_user" ? 1 : 0

  key          = "AWS_SECRET_ACCESS_KEY"
  value        = module.workspace_iam_user[0].secret_access_key
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

################################################################################
# Auth - IAM Role - External ID & Agent
################################################################################

resource "random_uuid" "external_id" {
  count = var.auth_method == "iam_role" ? 1 : 0
}

module "workspace_iam_role" {
  count  = var.auth_method == "iam_role" ? 1 : 0
  source = "github.com/schubergphilis/terraform-aws-mcaf-role?ref=v0.3.3"

  name                 = var.role_name
  path                 = var.path
  permissions_boundary = var.permissions_boundary_arn
  policy_arns          = var.policy_arns
  role_policy          = var.policy
  tags                 = var.tags

  assume_policy = templatefile("${path.module}/templates/assume_role_policy.tftpl", {
    external_id    = random_uuid.external_id[0].result,
    role_arns_json = jsonencode(var.agent_role_arns)
  })
}

resource "tfe_variable" "aws_assume_role" {
  count = var.auth_method == "iam_role" ? 1 : 0

  key          = "aws_assume_role"
  value        = module.workspace_iam_role[0].arn
  category     = "terraform"
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "aws_assume_role_external_id" {
  count = var.auth_method == "iam_role" ? 1 : 0

  key          = "aws_assume_role_external_id"
  value        = random_uuid.external_id[0].result
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

################################################################################
# Auth - IAM Role - OIDC
################################################################################

module "workspace_iam_role_oidc" {
  count  = local.enable_oidc ? 1 : 0
  source = "github.com/schubergphilis/terraform-aws-mcaf-role?ref=v0.3.3"

  name                 = var.role_name
  path                 = var.path
  permissions_boundary = var.permissions_boundary_arn
  policy_arns          = var.policy_arns
  role_policy          = var.policy
  tags                 = var.tags

  assume_policy = templatefile("${path.module}/templates/assume_role_policy_oidc.tftpl", {
    audience       = var.oidc_settings.audience,
    org_name       = var.terraform_organization,
    provider_arn   = var.oidc_settings.provider_arn,
    site_address   = var.oidc_settings.site_address,
    workspace_name = var.name
  })
}

resource "tfe_variable" "tfc_aws_provider_auth" {
  count = local.enable_oidc ? 1 : 0

  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "tfc_aws_run_role_arn" {
  count = local.enable_oidc ? 1 : 0

  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = module.workspace_iam_role_oidc[0].arn
  category     = "env"
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "tfc_aws_workload_identity_audience" {
  count = local.enable_oidc ? 1 : 0

  key          = "TFC_AWS_WORKLOAD_IDENTITY_AUDIENCE"
  value        = var.oidc_settings.audience
  category     = "env"
  workspace_id = tfe_workspace.default.id
}
