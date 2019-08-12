if platform?('ubuntu') && node['platform_version'] >= '18.04'
  replace_or_add 'Fix systemd-resolved conflict' do
    path '/etc/systemd/resolved.conf'
    pattern 'DNSStubListener=*'
    line 'DNSStubListener=no'
    notifies :restart, 'service[systemd-resolved]', :immediately
  end

  service 'systemd-resolved' do
    action :nothing
  end
end

package 'dnsmasq'
user 'dnsmasq'

include_recipe 'dnsmasq::dns' if node['dnsmasq']['enable_dns']
include_recipe 'dnsmasq::dhcp' if node['dnsmasq']['enable_dhcp']

service 'dnsmasq' do
  action [:enable, :start]
end
