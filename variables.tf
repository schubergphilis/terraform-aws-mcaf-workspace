variable "name" {
  type        = string
  description = "A name for the Terraform workspace"
}

variable "region" {
  type        = string
  default     = null
  description = "The default region of the account"
}

variable "agent_pool_id" {
  type        = string
  default     = null
  description = "Agent pool ID, requires \"execution_mode\" to be set to agent"
}

variable "agent_role_arn" {
  type        = string
  default     = null
  description = "IAM role ARN used by Terraform Cloud Agent to assume role in the created account"
}

variable "auth_method" {
  type        = string
  default     = "iam_user"
  description = "Configures how the workspace authenticates with the AWS account (can be iam_role or iam_user)"

  validation {
    condition     = lower(var.auth_method) == "iam_role" || lower(var.auth_method) == "iam_user"
    error_message = "The auth_method value must be either \"iam_role\" or \"iam_user\"."
  }
}

variable "auto_apply" {
  type        = bool
  default     = false
  description = "Whether to automatically apply changes when a Terraform plan is successful"
}

variable "branch" {
  type        = string
  default     = "main"
  description = "The git branch to trigger the TFE workspace for"
}

variable "clear_text_env_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text environment variables"
}

variable "clear_text_hcl_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text HCL Terraform variables"
}

variable "clear_text_terraform_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text Terraform variables"
}

variable "execution_mode" {
  type        = string
  default     = "remote"
  description = "Which execution mode to use"
}

variable "file_triggers_enabled" {
  type        = bool
  default     = true
  description = "Whether to filter runs based on the changed files in a VCS push"
}

variable "global_remote_state" {
  type        = bool
  default     = null
  description = "Allow all workspaces in the organization to read the state of this workspace"
}

variable "oauth_token_id" {
  type        = string
  description = "The OAuth token ID of the VCS provider"
}

variable "path" {
  type        = string
  default     = null
  description = "Path in which to create the iam_role or iam_user"
}

variable "policy" {
  type        = string
  default     = null
  description = "The policy to attach to the pipeline role or user"
}

variable "remote_state_consumer_ids" {
  type        = set(string)
  default     = null
  description = "A set of workspace IDs set as explicit remote state consumers for this workspace"
}

variable "permissions_boundary_arn" {
  type        = string
  default     = null
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role or IAM user."
}

variable "policy_arns" {
  type        = set(string)
  default     = []
  description = "A set of policy ARNs to attach to the pipeline user"
}

variable "repository_identifier" {
  type        = string
  default     = null
  description = "The repository identifier to connect the workspace to"
}

variable "role_name" {
  type        = string
  default     = null
  description = "The IAM role name for a new pipeline user"
}

variable "sensitive_env_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with sensitive environment variables"
}

variable "sensitive_terraform_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with sensitive Terraform variables"
}

variable "sensitive_hcl_variables" {
  type = map(object({
    sensitive = string
  }))
  default     = {}
  description = "An optional map with sensitive HCL Terraform variables"
}

variable "slack_notification_triggers" {
  type = list(string)
  default = [
    "run:created",
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored"
  ]
  description = "The triggers to send to Slack"
}

variable "slack_notification_url" {
  type        = string
  default     = null
  description = "The Slack Webhook URL to send notification to"
}

variable "ssh_key_id" {
  type        = string
  default     = null
  description = "The SSH key ID to assign to the workspace"
}

variable "team_access" {
  type = map(object({
    access = optional(string, null),
    permissions = optional(object({
      run_tasks         = bool
      runs              = string
      sentinel_mocks    = string
      state_versions    = string
      variables         = string
      workspace_locking = bool
    }), null)
  }))
  default     = {}
  description = "Map of team names and either type of fixed access or custom permissions to assign"

  validation {
    condition     = alltrue([for o in var.team_access : !(o.access != null && o.permissions != null)])
    error_message = "Cannot use \"access\" and \"permissions\" keys together when specifying a team's access."
  }
}

variable "terraform_version" {
  type        = string
  default     = "latest"
  description = "The version of Terraform to use for this workspace"
}

variable "terraform_organization" {
  type        = string
  description = "The Terraform Enterprise organization to create the workspace in"
}

variable "trigger_prefixes" {
  type        = list(string)
  default     = ["modules"]
  description = "List of repository-root-relative paths which should be tracked for changes"
}

variable "username" {
  type        = string
  default     = null
  description = "The username for a new pipeline user"
}

variable "working_directory" {
  type        = string
  default     = "terraform"
  description = "A relative path that Terraform will execute within"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resource"
}
