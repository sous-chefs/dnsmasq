# DNSMasq

[![Cookbook Version](https://img.shields.io/cookbook/v/dnsmasq.svg)](https://supermarket.chef.io/cookbooks/dnsmasq)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/dnsmasq/master.svg)](https://circleci.com/gh/sous-chefs/dnsmasq)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Install and configure dnsmasq.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Recipes

### default

Installs the `dnsmasq` package. Depending on the `[:dnsmasq][:enable_dns]` and `[:dnsmasq][:enable_dhcp]` attributes it includes the `dns` and `dhcp` recipes respectively.

## dhcp

Includes the `default` recipe and writes the contents of the `node[:dnsmasq][:dhcp]` attribute hash to `/etc/dnsmasq.d/dhcp.conf`. Here is an example of the necessary attributes for DHCP with TFTP enabled:

```ruby
'dnsmasq' => {
  'enable_dhcp' => true,
  'dhcp' => {
    'dhcp-authoritative' => nil,
    'dhcp-range' => 'eth0,10.0.0.10,10.0.0.100,12h',
    'dhcp-option' => '3', #turns off everything except basic DHCP
    'domain' => 'lab.atx',
    'interface' => 'eth0',
    'dhcp-boot' => 'pxelinux.0',
    'enable-tftp' => nil,
    'tftp-root' => '/var/lib/tftpboot',
    'tftp-secure' => nil
  }
}
```

### dns

Includes the `default` and `manage_hostsfile` recipes, then writes the content of the `node[:dnsmasq][:dns]` attribute hash to `/etc/dnsmasq.d/dns.conf`.

### manage_hostsfile

Loads the `dnsmasq` data bag `managed_hosts` item and merges it with any nodes in the `[:dnsmasq][:managed_hosts]` attribute, then writes them out to `/etc/hosts/` via the `hosts_file` cookbook.

## Usage

## Data Bag

If you need manage your DNS hosts you may use the `dnsmasq` data bag `managed_hosts` item. It takes the form:

```json
{
    "id": "managed_hosts",
    "maps": {
      "192.168.0.100": "www.google.com",
      "192.168.0.101": ["www.yahoo.com", "www.altavista.com"]
    }
}
```

## Attributes

- `[:dnsmasq][:enable_dns]` whether to enable the DNS service, default is `true`
- `[:dnsmasq][:enable_dhcp]` whether to enabled the DHCP service, default is `false`
- `[:dnsmasq][:managed_hosts]` hash of IPs and hostname/array of hostnames for the `manage_hostfile` recipe, default is empty
- `[:dnsmasq][:managed_hosts_bag]` name of the data bag item, default is `managed_hosts`
- `[:dnsmasq][:dhcp]` = hash of settings and values for the `/etc/dnsmasq.d/dhcp.conf`, default is empty
- `[:dnsmasq][:dhcp_options]` = list of options to be added to the `/etc/dnsmasq.d/dhcp.conf` (ie. `['dhcp-host=80:ee:73:0a:fa:d9,crushinator,10.0.0.11']`), default is empty.
- `[:dnsmasq][:dns]` hash of settings and values for the `/etc/dnsmasq.d/dns.conf`, defaults are

```ruby
{
  'no-poll' => nil,
  'no-resolv' => nil,
  'server' => '127.0.0.1'
}
```

- `[:dnsmasq][:dns_options]` = list of options to be added to the `/etc/dnsmasq.d/dns.conf`, default is empty.

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
