package 'dnsmasq'

# If resolvconf package is present we need to configure DNS,
# otherwise resolving will fail.
valid_resolv_config = node[:dnsmasq][:enable_dns] && !Array(node[:dnsmasq][:dns][:server]).any? {|ip| ip == '127.0.0.1'}

unless %x(which resolvconf).empty? || valid_resolv_config
  Chef::Log.error('Resolving will fail since your configuration is inconsistent')
  raise RuntimeError, "Provide external dns servers and enable dns in dnsmasq"
end

if node[:dnsmasq][:enable_dns]
  include_recipe 'dnsmasq::dns'
end

if node[:dnsmasq][:enable_dhcp]
  include_recipe 'dnsmasq::dhcp'
end

service 'dnsmasq' do
  action [:enable, :start]
end
