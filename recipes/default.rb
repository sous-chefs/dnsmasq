package 'dnsmasq'

if(node[:dnsmasq][:manage_hostsfile])
  include_recipe 'hosts_file'
end

service 'dnsmasq' do
  action :nothing
  subscribes :restart, resources(:template => 'managed_hosts_file'), :immediately
end

if(node[:dnsmasq][:enable_dns])
  include_recipe 'dnsmasq::dns'
end

if(node[:dnsmasq][:enable_dhcp])
  include_recipe 'dnsmasq::dhcp'
end
