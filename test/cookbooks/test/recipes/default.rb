# frozen_string_literal: true

apt_update 'update package cache' do
  retries 30
  retry_delay 2
  frequency 86_400
  action :periodic
  only_if { platform_family?('debian') }
end

package value_for_platform_family(
  default: 'bind-utils',
  'debian' => 'dnsutils'
)

dnsmasq 'default' do
  enable_dns true
  enable_dhcp true
  managed_hosts_data_bag false
  managed_hosts(
    '10.0.0.20' => ['router.test.lab', 'router']
  )
  dns_config(
    'no-poll' => nil,
    'no-resolv' => nil,
    'server' => '8.8.8.8'
  )
  dhcp_options ['dhcp-host=01:23:ab:cd:01:02,larry,10.0.0.10']
  dhcp_config(
    'dhcp-range' => '10.0.0.5,10.0.0.15,12h',
    'domain' => 'test.lab',
    'tftp-root' => '/var/lib/tftpboot',
    'enable-tftp' => nil,
    'except-interface' => 'lo'
  )
end
