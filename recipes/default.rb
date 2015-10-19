package 'dnsmasq'

file '/etc/dnsmasq.conf' do
  mode '0644'
  content 'conf-dir=/etc/dnsmasq.d'
  notifies :restart, 'service[dnsmasq]', :delayed
end

include_recipe 'dnsmasq::dns' if node['dnsmasq']['enable_dns']
include_recipe 'dnsmasq::dhcp' if node['dnsmasq']['enable_dhcp']

service 'dnsmasq' do
  action [:enable, :start]
end
