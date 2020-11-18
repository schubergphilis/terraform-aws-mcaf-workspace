# terraform-aws-mcaf-workspace

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| github | n/a |
| tfe | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| github\_repository | The Github organization to connect the workspace to | `string` | n/a | yes |
| name | A name for the Terraform workspace | `string` | n/a | yes |
| oauth\_token\_id | The OAuth token ID of the VCS provider | `string` | n/a | yes |
| tags | A mapping of tags to assign to resource | `map(string)` | n/a | yes |
| terraform\_organization | The Terraform Enterprise organization to create the workspace in | `string` | n/a | yes |
| auto\_apply | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| branch | The Git branch to trigger the TFE workspace for | `string` | `"master"` | no |
| branch\_protection | The Github branches to protect from forced pushes and deletion | <pre>list(object({<br>    branches          = list(string)<br>    enforce_admins    = bool<br>    push_restrictions = list(string)<br><br>    required_reviews = object({<br>      dismiss_stale_reviews           = bool<br>      dismissal_restrictions          = list(string)<br>      required_approving_review_count = number<br>      require_code_owner_reviews      = bool<br>    })<br><br>    required_checks = object({<br>      strict   = bool<br>      contexts = list(string)<br>    })<br>  }))</pre> | `[]` | no |
| clear\_text\_env\_variables | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| clear\_text\_terraform\_variables | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| connect\_vcs\_repo | Whether or not to connect a VCS repo to the workspace | `bool` | `true` | no |
| create\_backend\_config | Whether to create a backend.tf containing the remote backend config | `bool` | `true` | no |
| create\_repository | Whether of not to create a new repository | `bool` | `false` | no |
| delete\_branch\_on\_merge | Whether or not to delete the branch after a pull request is merged | `bool` | `true` | no |
| file\_triggers\_enabled | Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| github\_admins | A list of Github teams that should have admins access | `list(string)` | `[]` | no |
| github\_organization | The Github organization to connect the workspace to | `string` | `null` | no |
| github\_readers | A list of Github teams that should have read access | `list(string)` | `[]` | no |
| github\_writers | A list of Github teams that should have write access | `list(string)` | `[]` | no |
| kms\_key\_id | The KMS key ID used to encrypt the SSM parameters | `string` | `null` | no |
| policy | The policy to attach to the pipeline user | `string` | `null` | no |
| policy\_arns | A set of policy ARNs to attach to the pipeline user | `set(string)` | `[]` | no |
| region | The default region of the account | `string` | `null` | no |
| repository\_description | A description for the Github repository | `string` | `null` | no |
| repository\_visibility | Make the Github repository visibility | `string` | `"private"` | no |
| sensitive\_env\_variables | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| sensitive\_terraform\_variables | An optional map with sensitive Terraform variables | `map(string)` | `{}` | no |
| slack\_notification\_triggers | The triggers to send to Slack | `list(string)` | <pre>[<br>  "run:created",<br>  "run:planning",<br>  "run:needs_attention",<br>  "run:applying",<br>  "run:completed",<br>  "run:errored"<br>]</pre> | no |
| slack\_notification\_url | The Slack Webhook URL to send notification to | `string` | `null` | no |
| ssh\_key\_id | The SSH key ID to assign to the workspace | `string` | `null` | no |
| terraform\_version | The version of Terraform to use for this workspace | `string` | `"latest"` | no |
| trigger\_prefixes | List of repository-root-relative paths which should be tracked for changes | `list(string)` | <pre>[<br>  "modules"<br>]</pre> | no |
| username | The username for a new pipeline user. | `string` | `null` | no |
| working\_directory | A relative path that Terraform will execute within | `string` | `"terraform"` | no |

## Outputs

| Name | Description |
|------|-------------|
| repo\_full\_name | The full 'organization/repository' name of the repository |
| workspace\_id | The Terraform workspace ID |

<!--- END_TF_DOCS --->
