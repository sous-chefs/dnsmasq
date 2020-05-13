# CHANGELOG

This file is used to list changes made in each version of the Dnsmasq cookbooks.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

- resolved cookstyle error: recipes/dhcp.rb:8:44 convention: `Layout/TrailingWhitespace`
- resolved cookstyle error: recipes/dhcp.rb:8:45 refactor: `ChefModernize/FoodcriticComments`

## 0.3.3 - 2020-05-05

### Fixed

- Fix cookstyle warnings in the Dangerfile
- Migrated to github actions

## [0.3.2] - 2019-08-13

### Fixed

- systemd-resolved conflict (fixes #35)

## [0.3.1] - 2019-05-07

### Changed

- Switch testing from serverspec to inspec

## [0.3.0] - 2019-05-06

### Changed

- Require Chef 14 as it has builtin hotfle management
- update testing harness to use ServerSpec with Test Kitchen in lieu of MiniTest
- changed to circleci for testing

### Added

- add CONTRIBUTING documentation, update TESTING and README documentation

## [0.2.0] - 2013-12-23

### Added

- TFTP support
- Test Kitchen 1.0 coverage for Red Hat 5.9, 6.4, Debian 7.1 and Ubuntu 10.04, 12.04 and 13.04

### Fixed

- duplicate options support for dhcp and dns conf files, driven by dhcp_options and dns_options attributes

**Huge thanks to @mattray!**

## [0.1.2] - 2013-12-23

### Added

- initial version
