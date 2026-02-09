# Upgrading Notes

This document captures required refactoring on your part when upgrading to a module version that contains breaking changes.

## Upgrading to v3.0.0

### Variables (v3.0.0)

- The variable `project_id` has been replaced by `project_name`.
- The deprecated variable `trigger_prefixes` has been removed.
- The deprecated variable `workspace_tags` has been removed. `workspace_map_tags` has been renamed to `workspace_tags`.

## Upgrading to v2.4.0

### Variables (v2.4.0)

- Default value removed `var.trigger_prefixes`: `["modules"]` -> `null`
- Default value added `var.trigger_patterns`: `null` -> `["modules/**/*"]`.

### Behaviour (v2.4.0)

Terraform Cloud now defaults to **trigger patterns** instead of **trigger prefixes**. Trigger prefixes will be deprecated in the future, so migration is recommended. Trigger patterns providing greater flexibility, efficiency, and control over how your workspaces respond to changes in your repositories.

#### What You Need to Do

If you are using the modules defaults for these variables, you do not need to do anything, the workspaces will automatically be modified to trigger patterns.

If you have modified the defaults you need to take action:

Option 1: Migrate to `trigger_patterns` (Recommended)

1. **Remove** values from `trigger_prefixes`.
2. **Set** equivalent values in `trigger_patterns`.

**Example:**

```hcl
# Before
var.trigger_prefixes = ["envs/prod/"]

# After
var.trigger_patterns = ["envs/prod/**/*"]

See (documentation on trigger runs when files in specified paths change)[https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings/vcs#only-trigger-runs-when-files-in-specified-paths-change].
```

Option 2: Opt Out

1. Set `var.trigger_patterns` to `null`.
2. Set `var.trigger_prefixes` to `["modules"]`, or keep the value you are using.

This is a temporary workaround; trigger_prefixes will be deprecated.

#### Avoid Conflict Errors

If both variables are set, Terraform will fail with:

`"trigger_patterns": conflicts with trigger_prefixes`.
Fix it by following Option 1 or Option 2.
