# terraform-aws-mcaf-workspace

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| tfe | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | A name for the Terraform workspace | `string` | n/a | yes |
| oauth\_token\_id | The OAuth token ID of the VCS provider | `string` | n/a | yes |
| tags | A mapping of tags to assign to resource | `map(string)` | n/a | yes |
| terraform\_organization | The Terraform Enterprise organization to create the workspace in | `string` | n/a | yes |
| agent\_pool\_id | Agent pool ID, requires "execution\_mode" to be set to agent | `string` | `null` | no |
| auto\_apply | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| branch | The git branch to trigger the TFE workspace for | `string` | `"master"` | no |
| clear\_text\_env\_variables | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| clear\_text\_hcl\_variables | An optional map with clear text HCL Terraform variables | `map(string)` | `{}` | no |
| clear\_text\_terraform\_variables | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| execution\_mode | Which execution mode to use | `string` | `"remote"` | no |
| file\_triggers\_enabled | Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| global\_remote\_state | Allow all workspaces in the organization to read the state of this workspace | `bool` | `null` | no |
| policy | The policy to attach to the pipeline user | `string` | `null` | no |
| policy\_arns | A set of policy ARNs to attach to the pipeline user | `set(string)` | `[]` | no |
| region | The default region of the account | `string` | `null` | no |
| remote\_state\_consumer\_ids | A set of workspace IDs set as explicit remote state consumers for this workspace | `set(string)` | `null` | no |
| repository\_identifier | The VCS repository to connect the workspace to. E.g. for GitHub this is: <organization>/<repository> | `string` | `null` | no |
| sensitive\_env\_variables | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| sensitive\_hcl\_variables | An optional map with sensitive HCL Terraform variables | <pre>map(object({<br>    sensitive = string<br>  }))</pre> | `{}` | no |
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
| workspace\_id | The Terraform Cloud workspace ID |

<!--- END_TF_DOCS --->
