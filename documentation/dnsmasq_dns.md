# dnsmasq_dns

Manages the DNS-specific `dnsmasq` configuration file.

## Actions

| Action    | Description                                                   |
| --------- | ------------------------------------------------------------- |
| `:create` | Writes the DNS config file and restarts `dnsmasq` if needed   |
| `:delete` | Removes the DNS config file and restarts `dnsmasq` if needed  |

## Properties

| Property                 | Type          | Default                                                     | Description                                 |
| ------------------------ | ------------- | ----------------------------------------------------------- | ------------------------------------------- |
| `service_name`           | String        | `'dnsmasq'`                                                 | Service to notify on config changes         |
| `config_directory`       | String        | `'/etc/dnsmasq.d'`                                          | Configuration directory                     |
| `config_mode`            | String        | `'0644'`                                                    | Mode for the config file                    |
| `config_file`            | String        | `File.join(config_directory, 'dns.conf')`                   | DNS config file path                        |
| `config`                 | Hash          | `{'no-poll'=>nil, 'no-resolv'=>nil, 'server'=>'127.0.0.1'}` | DNS config key/value pairs                  |
| `options`                | String, Array | `[]`                                                        | Additional raw DNS config lines             |
| `disable_dhcp_interface` | Boolean       | `true`                                                      | Adds no-dhcp-interface if DHCP is off       |

## Examples

### Basic usage

```ruby
dnsmasq_dns 'default' do
  config(
    'server' => '8.8.8.8'
  )
end
```

### Allow DHCP on the same instance

```ruby
dnsmasq_dns 'default' do
  disable_dhcp_interface false
end
```
