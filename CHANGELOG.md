# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## v2.2.0 - 2025-01-10

### What's Changed

#### 🚀 Features

* feature: Support GitHub app for VCS connections, solve deprecation warning (#70) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v2.1.1...v2.2.0

## v2.1.1 - 2024-10-29

### What's Changed

#### 🐛 Bug Fixes

* fix: do not set `DEFAULT_REGION` env var if `var.region` is empty (#69) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v2.1.0...v2.1.1

## v2.1.0 - 2024-09-19

### What's Changed

#### 🚀 Features

* feat: Move User module to the TF Registry (#68) @fatbasstard
* enhancement: Move to use terraform-tfe-mcaf-workspace module (#67) @stefanwb

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v2.0.1...v2.1.0

## v2.0.1 - 2024-08-08

### What's Changed

#### 🐛 Bug Fixes

* fix: ensure that when `notification_configuration` or `team_access` is set to `null` the default value is used (#66) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v2.0.0...v2.0.1

## v2.0.0 - 2024-08-05

### What's Changed

#### 🚀 Features

* breaking: set default auth mode from 'iam_user' to 'iam_role_oidc' (#65) @marwinbaumannsbp
* breaking: solve bug where 'notification_configuration' can not contain sensitive values or values known after apply (#64) @marwinbaumannsbp

#### 🐛 Bug Fixes

* breaking: solve bug where 'notification_configuration' can not contain sensitive values or values known after apply (#64) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v1.3.0...v2.0.0

## v1.3.0 - 2024-07-29

### What's Changed

#### 🚀 Features

* feature: ability to pass down variable set id's that will be associated with the workspace (workspace variable set) (#62) @jorrite

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v1.2.0...v1.3.0

## v1.2.0 - 2024-07-25

### What's Changed

#### 🚀 Features

* feature: lifecycle management - add support for many new variables (#61) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v1.1.2...v1.2.0

## v1.1.2 - 2024-03-04

### What's Changed

#### 🐛 Bug Fixes

* fix(output): Add missing `workload_name` output (#60) @shoekstra

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v1.1.1...v1.1.2

## v1.1.1 - 2024-03-01

### What's Changed

#### 🐛 Bug Fixes

* fix: add condition to agent_pool_id to allow for unchanged MCAF AVM condition (#59) @marlonparmentier

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v1.1.0...v1.1.1

## v1.1.0 - 2023-12-19

### What's Changed

#### 🚀 Features

* enhancement: Refactor away deprecation warning & set minimum tfe version to v0.51.0 (#58) @fatbasstard

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v1.0.0...v1.1.0

## v1.0.0 - 2023-11-10

### What's Changed

#### 🚀 Features

- breaking: notification support for `microsoft-teams` (#57) @thulasirajkomminar
- feature: Add queue all runs (#56) @stromp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v0.15.1...v1.0.0

## v0.15.1 - 2023-09-14

### What's Changed

#### 📖 Documentation

- docs: adhere to latest workflow & set stricter versions (#55) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v0.15.0...v0.15.1

## v0.15.0 - 2023-09-07

### What's Changed

#### 🚀 Features

- feat: Add OIDC support (#54) @wvanheerde

**Full Changelog**: [https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v0.14.1...v0.15.0](https://github.com/schubergphilis/terraform-aws-mcaf-workspace/compare/v0.14.1...v0.15.0)
