node.default[:dnsmasq][:enable_dns] = true
node.default[:dnsmasq][:managed_hosts] = {
  '192.168.0.2' => 'google.com www.google.com mail.google.com',
  '192.168.0.3' => 'yahoo.com'
}

include_recipe 'dnsmasq'
