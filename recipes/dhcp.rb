
include_recipe 'dnsmasq::default'

template '/etc/dnsmasq.d/dhcp.conf' do
  source 'dynamic_config.erb'
  mode 0644
  variables(
    :config => node[:dnsmasq][:dhcp].to_hash
  )
  notifies :restart, resources(:service => 'dnsmasq'), :immediately
end
