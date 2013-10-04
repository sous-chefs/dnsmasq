node.default[:dnsmasq][:enable_dns] = true
node.default[:dnsmasq][:enable_dhcp] = true

node.default[:dnsmasq][:dhcp] = {
  'enable-tftp' => nil,
  'interface' => 'eth1'
}

include_recipe 'dnsmasq'
