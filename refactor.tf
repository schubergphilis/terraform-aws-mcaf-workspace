moved {
  from = module.workspace_account
  to   = module.workspace_iam_user[0]
}

moved {
  from = tfe_variable.aws_access_key_id
  to   = tfe_variable.aws_access_key_id[0]
}

moved {
  from = tfe_variable.aws_secret_access_key
  to   = tfe_variable.aws_secret_access_key[0]
}
