# We stop dnsmasq because resolv configuration is not yet consistent
service 'dnsmasq' do
  only_if "which resolvconf && [ ! -f /etc/dnsmasq.d/dns.conf ]"
  action :stop
end

include_recipe 'dnsmasq::default'
include_recipe 'dnsmasq::manage_hostsfile'

dns_config = node[:dnsmasq][:dns].to_hash
unless(node[:dnsmasq][:enable_dhcp])
  dns_config['no-dhcp-interface='] = nil
end

template '/etc/dnsmasq.d/dns.conf' do
  source 'dynamic_config.erb'
  mode 0644
  variables(
    :config => dns_config,
    :list => node['dnsmasq']['dns_options']
  )
  notifies :restart, "service[dnsmasq]"
end
