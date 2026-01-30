locals {
  enable_oidc = var.auth_method == "iam_role_oidc" && var.oidc_settings != null
}

################################################################################
# Workspace
################################################################################

module "tfe-workspace" {
  source  = "schubergphilis/mcaf-workspace/tfe"
  version = "~> 2.7.0"

  name                                         = var.name
  agent_pool_id                                = var.execution_mode == "agent" ? var.agent_pool_id : null
  allow_destroy_plan                           = var.allow_destroy_plan
  assessments_enabled                          = var.assessments_enabled
  auto_apply                                   = var.auto_apply
  auto_apply_run_trigger                       = var.auto_apply_run_trigger
  auto_destroy_activity_duration               = var.auto_destroy_activity_duration
  auto_destroy_at                              = var.auto_destroy_at
  branch                                       = var.branch
  clear_text_env_variables                     = var.region != null ? merge(var.clear_text_env_variables, { AWS_DEFAULT_REGION = var.region }) : var.clear_text_env_variables
  clear_text_hcl_variables                     = var.clear_text_hcl_variables
  clear_text_terraform_variables               = var.clear_text_terraform_variables
  description                                  = var.description
  execution_mode                               = var.execution_mode
  file_triggers_enabled                        = var.file_triggers_enabled
  force_delete                                 = var.force_delete
  github_app_installation_id                   = var.repository_identifier != null ? var.github_app_installation_id : null
  global_remote_state                          = var.global_remote_state
  notification_configuration                   = var.notification_configuration
  oauth_token_id                               = var.repository_identifier != null ? var.oauth_token_id : null
  project_id                                   = var.project_id
  queue_all_runs                               = var.queue_all_runs
  remote_state_consumer_ids                    = var.remote_state_consumer_ids
  repository_identifier                        = var.repository_identifier
  sensitive_env_variables                      = var.sensitive_env_variables
  sensitive_hcl_variables                      = var.sensitive_hcl_variables
  sensitive_terraform_variables                = var.sensitive_terraform_variables
  speculative_enabled                          = var.speculative_enabled
  ssh_key_id                                   = var.ssh_key_id
  terraform_organization                       = var.terraform_organization
  terraform_version                            = var.terraform_version
  trigger_patterns                             = var.trigger_patterns
  trigger_patterns_working_directory_recursive = var.trigger_patterns_working_directory_recursive
  trigger_prefixes                             = var.trigger_prefixes
  variable_set_ids                             = var.variable_set_ids
  variable_set_names                           = var.variable_set_names
  working_directory                            = var.working_directory
  workspace_map_tags                           = var.workspace_map_tags
  workspace_tags                               = var.workspace_tags
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
  workspace_id = module.tfe-workspace.workspace_id

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
  count = var.auth_method == "iam_user" ? 1 : 0

  source  = "schubergphilis/mcaf-user/aws"
  version = "~> 0.4.0"

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
  workspace_id = module.tfe-workspace.workspace_id
}

resource "tfe_variable" "aws_secret_access_key" {
  count = var.auth_method == "iam_user" ? 1 : 0

  key          = "AWS_SECRET_ACCESS_KEY"
  value        = module.workspace_iam_user[0].secret_access_key
  category     = "env"
  sensitive    = true
  workspace_id = module.tfe-workspace.workspace_id
}

################################################################################
# Auth - IAM Role - External ID & Agent
################################################################################

resource "random_uuid" "external_id" {
  count = var.auth_method == "iam_role" ? 1 : 0
}

module "workspace_iam_role" {
  count = var.auth_method == "iam_role" ? 1 : 0

  source  = "schubergphilis/mcaf-role/aws"
  version = "~> 0.4.0"

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
  workspace_id = module.tfe-workspace.workspace_id
}

resource "tfe_variable" "aws_assume_role_external_id" {
  count = var.auth_method == "iam_role" ? 1 : 0

  key          = "aws_assume_role_external_id"
  value        = random_uuid.external_id[0].result
  category     = "terraform"
  sensitive    = true
  workspace_id = module.tfe-workspace.workspace_id
}

################################################################################
# Auth - IAM Role - OIDC
################################################################################

data "tfe_projects" "all" {
  count = var.project_id != null ? 1 : 0

  organization = var.terraform_organization
}

locals {
  project_name = var.project_id != null ? one([
    for project in data.tfe_projects.all[0].projects :
    project.name if project.id == var.project_id
  ]) : null
}

module "workspace_iam_role_oidc" {
  count = local.enable_oidc ? 1 : 0

  source  = "schubergphilis/mcaf-role/aws"
  version = "~> 0.4.0"

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
  workspace_id = module.tfe-workspace.workspace_id
}

resource "tfe_variable" "tfc_aws_run_role_arn" {
  count = local.enable_oidc ? 1 : 0

  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = module.workspace_iam_role_oidc[0].arn
  category     = "env"
  workspace_id = module.tfe-workspace.workspace_id
}

resource "tfe_variable" "tfc_aws_workload_identity_audience" {
  count = local.enable_oidc ? 1 : 0

  key          = "TFC_AWS_WORKLOAD_IDENTITY_AUDIENCE"
  value        = var.oidc_settings.audience
  category     = "env"
  workspace_id = module.tfe-workspace.workspace_id
}
