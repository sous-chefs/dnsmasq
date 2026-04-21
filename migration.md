# Migration Guide

## Breaking Change

This cookbook now uses custom resources as its public interface. Operators
upgrading from older cookbook versions must treat this as a breaking change:
the legacy `recipes/` and `attributes/` interface is no longer the supported
way to configure dnsmasq.

If your existing wrapper cookbooks or roles do either of the following, update
them before you promote the new cookbook version:

* `include_recipe 'dnsmasq::default'`, `dnsmasq::dns`, `dnsmasq::dhcp`, or
  `dnsmasq::manage_hostsfile`
* set configuration with `node['dnsmasq'][...]` attributes

Those patterns need to move to resource declarations instead.

## What changed

The cookbook configuration surface moved from recipes and node attributes to
custom resources:

* `dnsmasq`
* `dnsmasq_dns`
* `dnsmasq_dhcp`
* `dnsmasq_managed_hosts`

DNS, DHCP, and managed-host settings now belong on resource properties instead
of node attributes.

## How to migrate

Legacy pattern:

```ruby
include_recipe 'dnsmasq::default'
include_recipe 'dnsmasq::dns'
include_recipe 'dnsmasq::dhcp'

node.default['dnsmasq']['dns']['server'] = '8.8.8.8'
node.default['dnsmasq']['dhcp']['dhcp-range'] = '10.0.0.5,10.0.0.15,12h'
```

Resource-first pattern:

```ruby
dnsmasq 'default' do
  enable_dns true
  enable_dhcp true
  managed_hosts_data_bag false
  dns_config(
    'server' => '8.8.8.8'
  )
  dhcp_config(
    'dhcp-range' => '10.0.0.5,10.0.0.15,12h',
    'except-interface' => 'lo'
  )
  managed_hosts(
    '10.0.0.20' => ['router.test.lab', 'router']
  )
end
```

## Attribute migration

Move legacy configuration hashes into resource properties:

* DNS settings -> `dns_config` and `dns_options`
* DHCP settings -> `dhcp_config` and `dhcp_options`
* managed hosts -> `managed_hosts`, `managed_hosts_data_bag`, `managed_hosts_data_bag_item`

If you prefer more granular declarations, use `dnsmasq_dns`, `dnsmasq_dhcp`,
and `dnsmasq_managed_hosts` directly.
