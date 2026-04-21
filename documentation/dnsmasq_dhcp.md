# dnsmasq_dhcp

Manages the DHCP-specific `dnsmasq` configuration file and optional TFTP root.

## Actions

| Action    | Description                                                    |
| --------- | -------------------------------------------------------------- |
| `:create` | Writes the DHCP config file and restarts `dnsmasq` if needed   |
| `:delete` | Removes the DHCP config file and restarts `dnsmasq` if needed  |

## Properties

| Property           | Type          | Default                                    | Description                         |
| ------------------ | ------------- | ------------------------------------------ | ----------------------------------- |
| `service_name`     | String        | `'dnsmasq'`                                | Service to notify on config changes |
| `config_directory` | String        | `'/etc/dnsmasq.d'`                         | Configuration directory             |
| `config_mode`      | String        | `'0644'`                                   | Mode for the config file            |
| `config_file`      | String        | `File.join(config_directory, 'dhcp.conf')` | DHCP config file path               |
| `user`             | String        | `'dnsmasq'`                                | Owner for a managed TFTP root       |
| `config`           | Hash          | `{}`                                       | DHCP config key/value pairs         |
| `options`          | String, Array | `[]`                                       | Additional raw DHCP config lines    |

## Examples

### Basic usage

```ruby
dnsmasq_dhcp 'default' do
  config(
    'dhcp-range' => 'eth1,10.0.0.5,10.0.0.15,12h',
    'interface' => 'eth1'
  )
end
```

### DHCP with TFTP

```ruby
dnsmasq_dhcp 'default' do
  config(
    'dhcp-range' => 'eth1,10.0.0.5,10.0.0.15,12h',
    'enable-tftp' => nil,
    'tftp-root' => '/var/lib/tftpboot'
  )
end
```
