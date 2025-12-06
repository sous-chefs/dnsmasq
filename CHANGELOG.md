# CHANGELOG

This file is used to list changes made in each version of the Dnsmasq cookbooks.

## [1.1.16](https://github.com/sous-chefs/dnsmasq/compare/v1.1.15...v1.1.16) (2025-12-06)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#108](https://github.com/sous-chefs/dnsmasq/issues/108)) ([d2454c2](https://github.com/sous-chefs/dnsmasq/commit/d2454c24f08f666d9d0193c5dcc30cd6174040e5))

## [1.1.15](https://github.com/sous-chefs/dnsmasq/compare/1.1.14...v1.1.15) (2025-10-15)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#108](https://github.com/sous-chefs/dnsmasq/issues/108)) ([d2454c2](https://github.com/sous-chefs/dnsmasq/commit/d2454c24f08f666d9d0193c5dcc30cd6174040e5))

## 1.1.9 - *2023-09-26*

* Fix typo in manage_hostsfile recipe

## 1.1.1 - *2023-02-14*

* Remove delivery folder

## 1.1.0 - *2021-08-31*

* Standardise the tested platforms

## 1.0.2 - *2021-08-31*

* Standardise files with files in sous-chefs/repo-management

## 1.0.1 - *2021-06-01*

* Standardise files with files in sous-chefs/repo-management

## 1.0.0 - *2021-05-24*

* Chef 17 compatibility
* Minimum version of Chef-Infra 15.3

## 0.3.4

* resolved cookstyle error: recipes/dhcp.rb:8:44 convention: `Layout/TrailingWhitespace`
* resolved cookstyle error: recipes/dhcp.rb:8:45 refactor: `ChefModernize/FoodcriticComments`

## 0.3.3 - 2020-05-05

* Fix cookstyle warnings in the Dangerfile
* Migrated to github actions

## [0.3.2] - 2019-08-13

* systemd-resolved conflict (fixes #35)

## [0.3.1] - 2019-05-07

* Switch testing from serverspec to inspec

## [0.3.0] - 2019-05-06

* Require Chef 14 as it has builtin hotfle management
* update testing harness to use ServerSpec with Test Kitchen in lieu of MiniTest
* changed to circleci for testing
* add CONTRIBUTING documentation, update TESTING and README documentation

## [0.2.0] - 2013-12-23

* TFTP support
* Test Kitchen 1.0 coverage for Red Hat 5.9, 6.4, Debian 7.1
 and Ubuntu 10.04, 12.04 and 13.04
* duplicate options support for dhcp and dns conf files,
 driven by dhcp_options and dns_options attributes

**Huge thanks to @mattray!**

## [0.1.2] - 2013-12-23

* initial version
