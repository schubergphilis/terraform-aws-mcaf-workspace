moved {
  from = tfe_workspace.default
  to   = module.tfe-workspace.tfe_workspace.default
}

moved {
  from = tfe_workspace_settings.default
  to   = module.tfe-workspace.tfe_workspace_settings.default
}

moved {
  from = tfe_notification_configuration.default
  to   = module.tfe-workspace.tfe_notification_configuration.default
}

moved {
  from = tfe_workspace_variable_set.default
  to   = module.tfe-workspace.tfe_workspace_variable_set.default
}

moved {
  from = tfe_variable.clear_text_env_variables
  to   = module.tfe-workspace.tfe_variable.clear_text_env_variables
}

moved {
  from = tfe_variable.clear_text_hcl_variables
  to   = module.tfe-workspace.tfe_variable.clear_text_hcl_variables
}

moved {
  from = tfe_variable.clear_text_terraform_variables
  to   = module.tfe-workspace.tfe_variable.clear_text_terraform_variables
}

moved {
  from = tfe_variable.sensitive_env_variables
  to   = module.tfe-workspace.tfe_variable.sensitive_env_variables
}

moved {
  from = tfe_variable.sensitive_hcl_variables
  to   = module.tfe-workspace.tfe_variable.sensitive_hcl_variables
}

moved {
  from = tfe_variable.sensitive_terraform_variables
  to   = module.tfe-workspace.tfe_variable.sensitive_terraform_variables
}
