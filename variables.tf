variable "name" {
  type        = string
  description = "A name for the Terraform workspace"
}

variable "agent_pool_id" {
  type        = string
  default     = null
  description = "Agent pool ID. Requires \"execution_mode\" to be set to agent"
}

variable "auto_apply" {
  type        = bool
  default     = false
  description = "Whether to automatically apply changes when a Terraform plan is successful"
}

variable "clear_text_env_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text environment variables"
}

variable "clear_text_hcl_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text HCL variables"
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

variable "region" {
  type        = string
  default     = null
  description = "The default region of the workspace"
}

variable "sensitive_env_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with sensitive environment variables"
}

variable "sensitive_hcl_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with sensitive HCL variables"
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

variable "vcs_repo" {
  type = object({
    branch         = string
    identifier     = string
    oauth_token_id = string
  })
  default     = null
  description = "VCS repository to connect to the workspace"
}

variable "working_directory" {
  type        = string
  default     = "terraform"
  description = "A relative path that Terraform will execute within"
}

variable "iam_user" {
  type = object({
    name        = string
    kms_key_id  = string
    policy      = string
    policy_arns = set(string)
    tags        = map(string)
  })
  description = "IAM User that should be used by the workspace"
}