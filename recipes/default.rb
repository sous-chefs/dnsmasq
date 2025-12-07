if platform?('ubuntu') && node['platform_version'] >= '18.04'
  Chef::Log.debug("Ubuntu 18.04 or higher detected, configuring systemd-resolved with DNSStubListener option at #{node['dnsmasq']['stublistener']}")
  directory '/etc/systemd/resolved.conf.d'

  file 'Fix systemd-resolved conflict' do
    path '/etc/systemd/resolved.conf.d/dnsmasq.conf'
    content "[Resolve]\nDNSStubListener=#{node['dnsmasq']['stublistener']}"
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
