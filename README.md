# terraform-aws-mcaf-workspace

Terraform module to create a Terraform Cloud workspace and either a IAM user or role in an AWS account. The user or role credentials are added to the workspace so that Terraform can create resources in the AWS account.

## Usage

### Team access

This module supports assigning an existing team access to the created workspace.

To do this, pass a map to `var.team_access` using the team name as the key and either `access` or `permissions` to assign a team access to the workspace.

Example using a pre-existing role (see [this link](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access#access) for allowed values):

```hcl
team_access = {
  "MyTeamName" = {
    access = "write"
  }
}
```

Example using a custom role (see [this link](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access#permissions) for a list of keys and their allowed values):

```hcl
team_access = {
  "MyTeamName" = {
    permissions = {
      run_tasks         = false
      runs              = "apply"
      sentinel_mocks    = "read"
      state_versions    = "read-outputs"
      variables         = "write"
      workspace_locking = true
    }
  }
}
```

The above custom role is similar to the "write" pre-existing role, but blocks access to the workspace state (which is considered sensitive).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_workspace_iam_role"></a> [workspace\_iam\_role](#module\_workspace\_iam\_role) | github.com/schubergphilis/terraform-aws-mcaf-role | v0.3.3 |
| <a name="module_workspace_iam_role_oidc"></a> [workspace\_iam\_role\_oidc](#module\_workspace\_iam\_role\_oidc) | github.com/schubergphilis/terraform-aws-mcaf-role | v0.3.3 |
| <a name="module_workspace_iam_user"></a> [workspace\_iam\_user](#module\_workspace\_iam\_user) | github.com/schubergphilis/terraform-aws-mcaf-user | v0.4.0 |

## Resources

| Name | Type |
|------|------|
| [random_uuid.external_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [tfe_notification_configuration.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration) | resource |
| [tfe_team_access.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_variable.aws_access_key_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_assume_role](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_assume_role_external_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_default_region](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_secret_access_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.clear_text_env_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.clear_text_hcl_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.clear_text_terraform_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_env_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_hcl_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_terraform_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_provider_auth](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_run_role_arn](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_workload_identity_audience](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_team.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | A name for the Terraform workspace | `string` | n/a | yes |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | The OAuth token ID of the VCS provider | `string` | n/a | yes |
| <a name="input_terraform_organization"></a> [terraform\_organization](#input\_terraform\_organization) | The Terraform Enterprise organization to create the workspace in | `string` | n/a | yes |
| <a name="input_agent_pool_id"></a> [agent\_pool\_id](#input\_agent\_pool\_id) | Agent pool ID, requires "execution\_mode" to be set to agent | `string` | `null` | no |
| <a name="input_agent_role_arns"></a> [agent\_role\_arns](#input\_agent\_role\_arns) | IAM role ARNs used by Terraform Cloud Agent to assume role in the created account | `list(string)` | `null` | no |
| <a name="input_auth_method"></a> [auth\_method](#input\_auth\_method) | Configures how the workspace authenticates with the AWS account (can be iam\_user, iam\_role, or iam\_role\_oidc) | `string` | `"iam_user"` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | The git branch to trigger the TFE workspace for | `string` | `"main"` | no |
| <a name="input_clear_text_env_variables"></a> [clear\_text\_env\_variables](#input\_clear\_text\_env\_variables) | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| <a name="input_clear_text_hcl_variables"></a> [clear\_text\_hcl\_variables](#input\_clear\_text\_hcl\_variables) | An optional map with clear text HCL Terraform variables | `map(string)` | `{}` | no |
| <a name="input_clear_text_terraform_variables"></a> [clear\_text\_terraform\_variables](#input\_clear\_text\_terraform\_variables) | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | Which execution mode to use | `string` | `"remote"` | no |
| <a name="input_file_triggers_enabled"></a> [file\_triggers\_enabled](#input\_file\_triggers\_enabled) | Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | Allow all workspaces in the organization to read the state of this workspace | `bool` | `null` | no |
| <a name="input_oidc_settings"></a> [oidc\_settings](#input\_oidc\_settings) | OIDC settings to use if "auth\_method" is set to "iam\_role\_oidc" | <pre>object({<br>    audience     = optional(string, "aws.workload.identity")<br>    provider_arn = string<br>    site_address = optional(string, "app.terraform.io")<br>  })</pre> | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the IAM role or user | `string` | `null` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | ARN of the policy that is used to set the permissions boundary for the IAM role or IAM user | `string` | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The policy to attach to the pipeline role or user | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | A set of policy ARNs to attach to the pipeline user | `set(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID of the project where the workspace should be created | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The default region of the account | `string` | `null` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | A set of workspace IDs set as explicit remote state consumers for this workspace | `set(string)` | `null` | no |
| <a name="input_repository_identifier"></a> [repository\_identifier](#input\_repository\_identifier) | The repository identifier to connect the workspace to | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The IAM role name for a new pipeline role | `string` | `null` | no |
| <a name="input_sensitive_env_variables"></a> [sensitive\_env\_variables](#input\_sensitive\_env\_variables) | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| <a name="input_sensitive_hcl_variables"></a> [sensitive\_hcl\_variables](#input\_sensitive\_hcl\_variables) | An optional map with sensitive HCL Terraform variables | <pre>map(object({<br>    sensitive = string<br>  }))</pre> | `{}` | no |
| <a name="input_sensitive_terraform_variables"></a> [sensitive\_terraform\_variables](#input\_sensitive\_terraform\_variables) | An optional map with sensitive Terraform variables | `map(string)` | `{}` | no |
| <a name="input_slack_notification_triggers"></a> [slack\_notification\_triggers](#input\_slack\_notification\_triggers) | The triggers to send to Slack | `list(string)` | <pre>[<br>  "run:created",<br>  "run:planning",<br>  "run:needs_attention",<br>  "run:applying",<br>  "run:completed",<br>  "run:errored"<br>]</pre> | no |
| <a name="input_slack_notification_url"></a> [slack\_notification\_url](#input\_slack\_notification\_url) | The Slack Webhook URL to send notification to | `string` | `null` | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | The SSH key ID to assign to the workspace | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to resource | `map(string)` | `null` | no |
| <a name="input_team_access"></a> [team\_access](#input\_team\_access) | Map of team names and either type of fixed access or custom permissions to assign | <pre>map(object({<br>    access = optional(string, null),<br>    permissions = optional(object({<br>      run_tasks         = bool<br>      runs              = string<br>      sentinel_mocks    = string<br>      state_versions    = string<br>      variables         = string<br>      workspace_locking = bool<br>    }), null)<br>  }))</pre> | `{}` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The version of Terraform to use for this workspace | `string` | `"latest"` | no |
| <a name="input_trigger_prefixes"></a> [trigger\_prefixes](#input\_trigger\_prefixes) | List of repository-root-relative paths which should be tracked for changes | `list(string)` | <pre>[<br>  "modules"<br>]</pre> | no |
| <a name="input_username"></a> [username](#input\_username) | The username for a new pipeline user | `string` | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | A relative path that Terraform will execute within | `string` | `"terraform"` | no |
| <a name="input_workspace_tags"></a> [workspace\_tags](#input\_workspace\_tags) | A list of tag names for this workspace. Note that tags must only contain lowercase letters, numbers, colons, or hyphens | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The workspace IAM user ARN |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The Terraform Cloud workspace ID |
<!-- END_TF_DOCS -->
