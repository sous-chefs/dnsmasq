# DNSMasq

[![Cookbook Version](https://img.shields.io/cookbook/v/dnsmasq.svg)](https://supermarket.chef.io/cookbooks/dnsmasq)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/dnsmasq/master.svg)](https://circleci.com/gh/sous-chefs/dnsmasq)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Install and configure `dnsmasq` with custom resources.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Resources

### `dnsmasq`

Top-level resource that installs the package, enables the service, and can
manage DNS, DHCP, and hosts data in one declaration.

```ruby
dnsmasq 'default' do
  enable_dns true
  enable_dhcp true
  managed_hosts_data_bag false
  managed_hosts(
    '10.0.0.20' => ['router.test.lab', 'router']
  )
  dns_config(
    'server' => '8.8.8.8'
  )
  dhcp_config(
    'dhcp-range' => 'eth1,10.0.0.5,10.0.0.15,12h',
    'interface' => 'eth1',
    'tftp-root' => '/var/lib/tftpboot',
    'enable-tftp' => nil
  )
  dhcp_options ['dhcp-host=01:23:ab:cd:01:02,larry,10.0.0.10']
end
```

### `dnsmasq_dns`

Manages `/etc/dnsmasq.d/dns.conf`.

### `dnsmasq_dhcp`

Manages `/etc/dnsmasq.d/dhcp.conf` and the optional TFTP root directory.

### `dnsmasq_managed_hosts`

Manages `/etc/hosts` entries for `dnsmasq`, optionally merging a data bag item.

Detailed resource documentation lives in:

- `documentation/dnsmasq_dnsmasq.md`
- `documentation/dnsmasq_dns.md`
- `documentation/dnsmasq_dhcp.md`
- `documentation/dnsmasq_managed_hosts.md`

## Data Bag

If you want to merge managed hosts from a data bag, use the `dnsmasq` data bag
and the `managed_hosts` item by default. It takes the form:

```json
{
    "id": "managed_hosts",
    "maps": {
      "192.168.0.100": "www.google.com",
      "192.168.0.101": ["www.yahoo.com", "www.altavista.com"]
    }
}
```

## Notes

- This cookbook no longer uses root-level recipes or attributes.
- Configuration defaults now live on resource properties instead of node
  attributes.
- Managed hosts still use the `hostsfile` cookbook under the hood.

## Testing

Please refer to the [TESTING file](TESTING.md) to see instructions for testing this cookbook.

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
