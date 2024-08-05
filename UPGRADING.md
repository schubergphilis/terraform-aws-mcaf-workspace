This document captures breaking changes.

## Upgrading to v2.0.0

### Variables

- `notification_configuration` has been modified from a `list(object)` to a `map(object)`. They key should be the name of the notification configuration as it will be displayed in Terraform Cloud.
- The default `auth_method` has been modified from `iam_user` to `iam_role_oidc`.

## Upgrading to v1.0.0

### Variables

The following variables have been merged:

- `slack_notification_triggers` & `slack_notification_url` -> `notification_configuration`

This allows to easily configure notifications for both slack and teams.
