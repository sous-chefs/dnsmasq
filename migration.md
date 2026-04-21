# Migration Guide

This cookbook migrated from root-level recipes and attributes to custom resources.

## What changed

* Root `attributes/` and `recipes/` usage was replaced by resource properties.
* The public interface is now:
  * `dnsmasq`
  * `dnsmasq_dns`
  * `dnsmasq_dhcp`
  * `dnsmasq_managed_hosts`
* DNS, DHCP, and managed-host settings now belong on resources instead of node attributes.

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

If you prefer more granular declarations, use `dnsmasq_dns`, `dnsmasq_dhcp`, and `dnsmasq_managed_hosts` directly.

## Important note

The migrated cookbook still uses the `hostsfile` cookbook for managed entries under the hood, but consumers should treat the dnsmasq resources as the public API.
