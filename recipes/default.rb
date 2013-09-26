package 'dnsmasq'

service 'dnsmasq' do
  action [:enable, :start]
  if(node[:dnsmasq][:enable_dns])
    subscribes :restart, resources(:template => 'managed_hosts_file'), :immediately
  end
end

if(node[:dnsmasq][:enable_dns])
  include_recipe 'dnsmasq::dns'
end

if(node[:dnsmasq][:enable_dhcp])
  include_recipe 'dnsmasq::dhcp'
end
