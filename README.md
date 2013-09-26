# DNSMasq

Install and configure dnsmasq

# Recipes

## default
Installs the `dnsmasq` package. Depending on the `[:dnsmasq][:enable_dns]` and `[:dnsmasq][:enable_dhcp]` attributes it includes the `dns` and `dhcp` recipes respectively.

## dhcp

## dns

## manage_hostsfile

# Usage

## Data Bag

## Attributes

`[:dnsmasq][:enable_dns]` = true
`[:dnsmasq][:enable_dhcp]` = false
`[:dnsmasq][:managed_hosts]` = {}
`[:dnsmasq][:managed_hosts_bag]` = "managed_hosts"
`[:dnsmasq][:dns]` = {
  'no-poll' => nil,
  'no-resolv' => nil,
  'server' => '127.0.0.1'
}
`[:dnsmasq][:dhcp]` = {}

# Repo:

* https://github.com/hw-cookbooks/dnsmasq
