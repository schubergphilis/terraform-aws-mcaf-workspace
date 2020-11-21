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

variable "create_backend_config" {
  type        = bool
  default     = true
  description = "Whether to create a backend.tf containing the remote backend config"
}

variable "create_repository" {
  type        = bool
  default     = false
  description = "Whether of not to create a new repository"
}

variable "delete_branch_on_merge" {
  type        = bool
  default     = true
  description = "Whether or not to delete the branch after a pull request is merged"
}

variable "file_triggers_enabled" {
  type        = bool
  default     = true
  description = "Whether to filter runs based on the changed files in a VCS push"
}

variable "github_admins" {
  type        = list(string)
  default     = []
  description = "A list of GitHub teams that should have admins access"
}

variable "github_branch_protection" {
  type = list(object({
    branches          = list(string)
    enforce_admins    = bool
    push_restrictions = list(string)

    required_reviews = object({
      dismiss_stale_reviews           = bool
      dismissal_restrictions          = list(string)
      required_approving_review_count = number
      require_code_owner_reviews      = bool
    })

    required_checks = object({
      strict   = bool
      contexts = list(string)
    })
  }))
  default     = []
  description = "The GitHub branches to protect from forced pushes and deletion"
}

variable "github_readers" {
  type        = list(string)
  default     = []
  description = "A list of GitHub teams that should have read access"
}

variable "github_writers" {
  type        = list(string)
  default     = []
  description = "A list of GitHub teams that should have write access"
}

variable "gitlab_branch_protection" {
  type = map(object({
    push_access_level            = string
    merge_access_level           = string
    code_owner_approval_required = bool
  }))
  default     = null
  description = "The GitLab branches to protect from forced pushes and deletion"
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
  description = "A description for the GitHub or GitLab repository"
}

variable "repository_name" {
  type        = string
  description = "The GitHub or GitLab repository to connect the workspace to"
}

variable "repository_owner" {
  type        = string
  default     = null
  description = "The GitHub organization or GitLab namespace that owns the repository"
}

variable "repository_visibility" {
  type        = string
  default     = "private"
  description = "Make the GitHub repository visibility"

  validation {
    condition     = contains(["internal", "private", "public"], var.repository_visibility)
    error_message = "The repository_visibility value must be either \"internal\", \"private\" or \"public\"."
  }
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

variable "vcs_provider" {
  type        = string
  default     = "github"
  description = "The VCS provider to use"

  validation {
    condition     = lower(var.vcs_provider) == "github" || lower(var.vcs_provider) == "gitlab"
    error_message = "The vcs_provider value must be either \"github\" or \"gitlab\"."
  }
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to resource"
}
