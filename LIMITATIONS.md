# dnsmasq Cookbook Limitations

This cookbook now manages `dnsmasq` through custom resources and expects a
package-based, systemd-managed Linux install.

## Upstream Product Scope

* Upstream `dnsmasq` supports Linux, Android, BSD, and macOS, and can be
  compiled from source with `make install`.
* This cookbook does not implement source builds. It assumes a distro package
  called `dnsmasq` and a service called `dnsmasq`.
* This cookbook is therefore intentionally scoped to Linux distributions where
  `dnsmasq` is provided by the vendor or distribution package repositories.

## Package Availability

* Debian 12 (bookworm) and Debian 13 (trixie, released 2025-08-09) package
  `dnsmasq`, `dnsmasq-base`, and `dnsmasq-utils`. `dnsmasq-base` is published
  for multiple architectures including `amd64`, `arm64`, `armel`, `armhf`,
  `i386`, `ppc64el`, `riscv64`, and `s390x`.
* Ubuntu publishes `dnsmasq` and `dnsmasq-base` in `universe` for current LTS
  releases including 22.04 and 24.04. `dnsmasq-base` is available on `amd64`,
  `arm64`, `armhf`, `ppc64el`, `riscv64`, and `s390x`.
* Red Hat documentation and package manifests show `dnsmasq` and
  `dnsmasq-utils` for RHEL 8 and RHEL 9.
* Amazon Linux 2023 publishes `dnsmasq` and `dnsmasq-utils` for `x86_64` and
  `aarch64`, with package support listed through 2029-06-30.
* Oracle Linux AppStream publishes `dnsmasq` for OL8 and OL9.
* Fedora publishes `dnsmasq` and `dnsmasq-utils` for active Fedora releases.

## Platform Constraints

* Ubuntu support in this cookbook starts at 22.04. Ubuntu 20.04 is past
  standard support, and `dnsmasq` lives in `universe`, which has weaker support
  guarantees than `main`.
* Debian 11 (Bullseye) standard EOL was 2024-08-14 and should not remain in
  Kitchen or CI. Debian 12 and 13 are the current supported releases.
* CentOS 7 and CentOS Stream 8 are EOL and should not remain in Kitchen or CI.
* openSUSE Leap is intentionally not supported by this cookbook after the
  migration. The current openSUSE package index shows no official `dnsmasq`
  package for Leap 15.6 or Leap 16.0, only experimental or community packages.

## Architecture Notes

* The cookbook itself is architecture-neutral Ruby/Chef code.
* Effective architecture support is bounded by the vendor package repositories
  listed above.
* No cookbook logic depends on compiling `dnsmasq` from source or on
  architecture-specific paths.

## Operational Assumptions

* Service management uses the distro-provided `dnsmasq` system service.
* Configuration is written under `/etc/dnsmasq.d`.
* Managed hosts integration updates `/etc/hosts` through the `hostsfile`
  cookbook dependency.
