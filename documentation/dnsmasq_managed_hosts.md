# dnsmasq_managed_hosts

Manages `dnsmasq`-related `/etc/hosts` entries through the `hostsfile` cookbook.

## Actions

| Action    | Description                                 |
| --------- | ------------------------------------------- |
| `:create` | Creates managed hosts entries for `dnsmasq` |
| `:delete` | Removes managed hosts entries for `dnsmasq` |

## Properties

| Property        | Type                         | Default                   | Description                        |
| --------------- | ---------------------------- | ------------------------- | ---------------------------------- |
| `service_name`  | String                       | `'dnsmasq'`               | Service notified on hosts changes  |
| `entries`       | Hash                         | `{}`                      | Explicit IP-to-hostname mappings   |
| `data_bag`      | String, NilClass, FalseClass | `'dnsmasq'`               | Data bag name for extra mappings   |
| `data_bag_item` | String, NilClass, FalseClass | `'managed_hosts'`         | Data bag item for extra mappings   |
| `comment`       | String                       | `'dnsmasq managed entry'` | Comment for `/etc/hosts` lines     |

## Examples

### Basic usage

```ruby
dnsmasq_managed_hosts 'default' do
  data_bag false
  entries(
    '10.0.0.20' => ['router.test.lab', 'router']
  )
end
```

### Data bag driven usage

```ruby
dnsmasq_managed_hosts 'default' do
  data_bag 'dnsmasq'
  data_bag_item 'managed_hosts'
end
```
