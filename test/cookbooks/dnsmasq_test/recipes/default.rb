node.default[:hosts_file][:path] = '/tmp/hosts'
node.default[:dnsmasq][:enable_dns] = true
node.default[:dnsmasq][:managed_hosts] = {
  '192.168.0.2' => 'google.com www.google.com mail.google.com',
  '192.168.0.3' => 'yahoo.com'
}

node.default[:dnsmasq][:enable_dhcp] = true
node.default[:dnsmasq][:dhcp] = {
  'enable-tftp' => nil,
  'interface' => 'eth1',
  'domain' => 'yourdomain.com',
  'tftp-root' => '/var/lib/tftpboot'
}

include_recipe 'dnsmasq'
