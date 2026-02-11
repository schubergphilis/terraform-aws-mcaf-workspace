# IAM User resources
moved {
  from = module.workspace_iam_user
  to   = module.auth.module.workspace_iam_user
}

moved {
  from = tfe_variable.aws_access_key_id
  to   = module.auth.tfe_variable.aws_access_key_id
}

moved {
  from = tfe_variable.aws_secret_access_key
  to   = module.auth.tfe_variable.aws_secret_access_key
}

# IAM Role (Agent) resources
moved {
  from = random_uuid.external_id
  to   = module.auth.random_uuid.external_id
}

moved {
  from = module.workspace_iam_role
  to   = module.auth.module.workspace_iam_role
}

moved {
  from = tfe_variable.aws_assume_role
  to   = module.auth.tfe_variable.aws_assume_role
}

moved {
  from = tfe_variable.aws_assume_role_external_id
  to   = module.auth.tfe_variable.aws_assume_role_external_id
}

# IAM Role (OIDC) resources
moved {
  from = module.workspace_iam_role_oidc
  to   = module.auth.module.workspace_iam_role_oidc
}

moved {
  from = tfe_variable.tfc_aws_provider_auth
  to   = module.auth.tfe_variable.tfc_aws_provider_auth
}

moved {
  from = tfe_variable.tfc_aws_run_role_arn
  to   = module.auth.tfe_variable.tfc_aws_run_role_arn
}

moved {
  from = tfe_variable.tfc_aws_workload_identity_audience
  to   = module.auth.tfe_variable.tfc_aws_workload_identity_audience
}
