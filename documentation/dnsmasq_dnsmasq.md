# dnsmasq_dnsmasq

Installs and runs `dnsmasq`, and optionally manages DNS, DHCP, and hosts data
through the companion resources.

## Actions

| Action    | Description                    |
|-----------|--------------------------------|
| `:create` | Installs, configures, and runs `dnsmasq` (default) |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `package_name` | String | `'dnsmasq'` | Package to install |
| `service_name` | String | `'dnsmasq'` | Service to enable and start |
| `config_directory` | String | `'/etc/dnsmasq.d'` | Configuration directory |
| `config_mode` | String | `'0644'` | Mode for generated config files |
| `user` | String | `'dnsmasq'` | System user for dnsmasq-owned paths |
| `enable_dns` | Boolean | `true` | Whether to manage `dns.conf` |
| `dns_config` | Hash | `{'no-poll'=>nil, 'no-resolv'=>nil, 'server'=>'127.0.0.1'}` | DNS config key/value pairs |
| `dns_options` | String, Array | `[]` | Additional DNS config lines |
| `enable_dhcp` | Boolean | `false` | Whether to manage `dhcp.conf` |
| `dhcp_config` | Hash | `{}` | DHCP config key/value pairs |
| `dhcp_options` | String, Array | `[]` | Additional DHCP config lines |
| `managed_hosts` | Hash | `{}` | `/etc/hosts` entries to manage |
| `managed_hosts_data_bag` | String, NilClass, FalseClass | `'dnsmasq'` | Data bag name for managed hosts |
| `managed_hosts_data_bag_item` | String, NilClass, FalseClass | `'managed_hosts'` | Data bag item name for managed hosts |
| `manage_systemd_resolved` | Boolean | platform-dependent | Disable Ubuntu `systemd-resolved` stub listener when needed |

## Examples

### Basic DNS cache

```ruby
dnsmasq 'default' do
  managed_hosts_data_bag false
end
```

### DNS and DHCP

```ruby
dnsmasq 'default' do
  enable_dhcp true
  managed_hosts_data_bag false
  dns_config(
    'server' => '8.8.8.8'
  )
  dhcp_config(
    'dhcp-range' => 'eth1,10.0.0.5,10.0.0.15,12h',
    'interface' => 'eth1'
  )
  dhcp_options ['dhcp-host=01:23:ab:cd:01:02,larry,10.0.0.10']
end
```
