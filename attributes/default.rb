default[:dnsmasq][:enable_dns] = true
default[:dnsmasq][:enable_dhcp] = false
default[:dnsmasq][:managed_hosts] = {}
default[:dnsmasq][:dns] = {
  'no-poll' => nil,
  'no-resolv' => nil,
  'server' => '127.0.0.1'
}
default[:dnsmasq][:dhcp] = {}
