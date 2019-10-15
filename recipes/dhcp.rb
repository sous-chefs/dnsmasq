include_recipe 'dnsmasq::default'

directory node['dnsmasq']['dhcp']['tftp-root'] do
  owner node['dnsmasq']['user']
  mode '755'
  recursive true
  action :create
end if node['dnsmasq']['dhcp']['tftp-root'] # ~FC023

template '/etc/dnsmasq.d/dhcp.conf' do
  source 'dynamic_config.erb'
  mode '644'
  variables lazy {
    {
      config: node['dnsmasq']['dhcp'].to_hash,
      list: node['dnsmasq']['dhcp_options'],
    }
  }
  notifies :restart, 'service[dnsmasq]', :immediately
end
