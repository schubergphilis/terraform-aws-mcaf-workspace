<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.67.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | >= 0.67.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_workspace_iam_role"></a> [workspace\_iam\_role](#module\_workspace\_iam\_role) | schubergphilis/mcaf-role/aws | ~> 0.4.0 |
| <a name="module_workspace_iam_role_oidc"></a> [workspace\_iam\_role\_oidc](#module\_workspace\_iam\_role\_oidc) | schubergphilis/mcaf-role/aws | ~> 0.5.3 |
| <a name="module_workspace_iam_user"></a> [workspace\_iam\_user](#module\_workspace\_iam\_user) | schubergphilis/mcaf-user/aws | ~> 0.4.0 |

## Resources

| Name | Type |
|------|------|
| [random_uuid.external_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [tfe_variable.aws_access_key_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_assume_role](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_assume_role_external_id](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.aws_secret_access_key](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_provider_auth](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_run_role_arn](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_aws_workload_identity_audience](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_role_arns"></a> [agent\_role\_arns](#input\_agent\_role\_arns) | IAM role ARNs used by Terraform Cloud Agent to assume role in the created account | `list(string)` | `null` | no |
| <a name="input_auth_method"></a> [auth\_method](#input\_auth\_method) | Configures how the workspace authenticates with the AWS account (can be iam\_user, iam\_role, or iam\_role\_oidc) | `string` | `"iam_role_oidc"` | no |
| <a name="input_oidc_settings"></a> [oidc\_settings](#input\_oidc\_settings) | OIDC settings to use if "auth\_method" is set to "iam\_role\_oidc" | <pre>object({<br/>    audience              = optional(string, "aws.workload.identity")<br/>    oidc_project_filter   = optional(string, "*")<br/>    oidc_workspace_filter = string<br/>    provider_arn          = string<br/>    site_address          = optional(string, "app.terraform.io")<br/>  })</pre> | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the IAM role or user | `string` | `null` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | ARN of the policy that is used to set the permissions boundary for the IAM role or IAM user | `string` | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The policy to attach to the pipeline role or user | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | A set of policy ARNs to attach to the pipeline user | `set(string)` | `[]` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The IAM role name for a new pipeline role | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to resource | `map(string)` | `null` | no |
| <a name="input_terraform_organization"></a> [terraform\_organization](#input\_terraform\_organization) | The Terraform Enterprise organization to create the workspace in | `string` | `null` | no |
| <a name="input_username"></a> [username](#input\_username) | The username for a new pipeline user | `string` | `null` | no |
| <a name="input_variable_set_id"></a> [variable\_set\_id](#input\_variable\_set\_id) | The TFE variable set ID to attach variables to | `string` | `null` | no |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | The TFE workspace ID to attach variables to | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the IAM role (if auth\_method is iam\_role) |
| <a name="output_iam_role_oidc_arn"></a> [iam\_role\_oidc\_arn](#output\_iam\_role\_oidc\_arn) | ARN of the IAM role for OIDC (if auth\_method is iam\_role\_oidc) |
| <a name="output_iam_user_arn"></a> [iam\_user\_arn](#output\_iam\_user\_arn) | ARN of the IAM user (if auth\_method is iam\_user) |
<!-- END_TF_DOCS -->