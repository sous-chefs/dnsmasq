if platform?('ubuntu') && node['platform_version'] >= '18.04'
  service 'systemd-resolved' do
    action :stop
  end
end

package 'dnsmasq'
user 'dnsmasq'

include_recipe 'dnsmasq::dns' if node['dnsmasq']['enable_dns']
include_recipe 'dnsmasq::dhcp' if node['dnsmasq']['enable_dhcp']

service 'dnsmasq' do
  action [:enable, :start]
end
