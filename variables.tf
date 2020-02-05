variable "name" {
  type        = string
  description = "A name for the Terraform workspace"
}

variable "region" {
  type        = string
  default     = null
  description = "The default region of the account"
}

variable "auto_apply" {
  type        = bool
  default     = false
  description = "Whether to automatically apply changes when a Terraform plan is successful"
}

variable "branch" {
  type        = string
  default     = "master"
  description = "The Git branch to trigger the TFE workspace for"
}

variable "clear_text_env_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text environment variables"
}

variable "clear_text_terraform_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text Terraform variables"
}

variable "create_repository" {
  type        = bool
  default     = false
  description = "Whether of not to create a new repository"
}

variable "connect_vcs_repo" {
  type        = bool
  default     = true
  description = "Whether or not to connect a VCS repo to the workspace"
}

variable "file_triggers_enabled" {
  type        = bool
  default     = true
  description = "Whether to filter runs based on the changed files in a VCS push"
}

variable "github_admins" {
  type        = list(string)
  default     = []
  description = "A list of Github teams that should have admins access"
}

variable "github_organization" {
  type        = string
  description = "The Github organization to connect the workspace to"
}

variable "github_protection" {
  type = list(object({
    branch  = string
    context = list(string)
  }))
  default = [{
    branch  = "master"
    context = []
  }]
  description = "The Github branches to protect from forced pushes and deletion"
}

variable "github_repository" {
  type        = string
  description = "The Github organization to connect the workspace to"
}

variable "github_writers" {
  type        = list(string)
  default     = []
  description = "A list of Github teams that should have write access"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "The KMS key ID used to encrypt the SSM parameters"
}

variable "oauth_token_id" {
  type        = string
  description = "The OAuth token ID of the VCS provider"
}

variable "policy" {
  type        = string
  default     = null
  description = "The policy to attach to the pipeline user"
}

variable "policy_arns" {
  type        = set(string)
  default     = []
  description = "A set of policy ARNs to attach to the pipeline user"
}

variable "repository_description" {
  type        = string
  default     = null
  description = "A description for the Github repository"
}

variable "repository_private" {
  type        = bool
  default     = true
  description = "Make the Github repository private"
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

variable "slack_notification_url" {
  type        = string
  default     = null
  description = "The Slack Webhook URL to send notification to"
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
  description = "The username for a new pipeline user."
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
