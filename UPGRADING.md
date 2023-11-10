This document captures breaking changes.

## Upgrading to v1.0.0

### Variables

The following variables have been merged:

- `slack_notification_triggers` & `slack_notification_url` -> `notification_configuration`

This allows to easily configure notifications for both slack and teams.
