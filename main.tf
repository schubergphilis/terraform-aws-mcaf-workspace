module "workspace" {
  source = "github.com/schubergphilis/terraform-tfe-mcaf-workspace?ref=GCTAM-26"

  name                           = var.name
  agent_pool_id                  = var.agent_pool_id
  auto_apply                     = var.auto_apply
  clear_text_env_variables       = var.clear_text_env_variables
  clear_text_hcl_variables       = var.clear_text_hcl_variables
  clear_text_terraform_variables = var.clear_text_terraform_variables
  execution_mode                 = var.execution_mode
  file_triggers_enabled          = var.file_triggers_enabled
  sensitive_env_variables        = var.sensitive_env_variables
  sensitive_hcl_variables        = var.sensitive_hcl_variables
  sensitive_terraform_variables  = var.sensitive_terraform_variables
  slack_notification_triggers    = var.slack_notification_triggers
  slack_notification_url         = var.slack_notification_url
  ssh_key_id                     = var.ssh_key_id
  terraform_version              = var.terraform_version
  terraform_organization         = var.terraform_organization
  trigger_prefixes               = var.trigger_prefixes
  vcs_repo                       = var.vcs_repo
  working_directory              = var.working_directory
}

module "workspace_account" {
  source      = "github.com/schubergphilis/terraform-aws-mcaf-user?ref=v0.1.6"
  name        = var.iam_user.name
  kms_key_id  = var.iam_user.kms_key_id
  policy      = var.iam_user.policy
  policy_arns = var.iam_user.policy_arns
  tags        = var.iam_user.tags
}

resource "tfe_variable" "aws_access_key_id" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = module.workspace_account.access_key_id
  category     = "env"
  sensitive    = true
  workspace_id = module.workspace.id
}

resource "tfe_variable" "aws_secret_access_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = module.workspace_account.secret_access_key
  category     = "env"
  sensitive    = true
  workspace_id = module.workspace.id
}

resource "tfe_variable" "aws_default_region" {
  key          = "AWS_DEFAULT_REGION"
  value        = var.region
  category     = "env"
  sensitive    = true
  workspace_id = module.workspace.id
}
