package 'dnsmasq'

# If resolvconf package is present we need to configure DNS,
# otherwise resolving will fail.
valid_resolv_config = node[:dnsmasq][:enable_dns] && !Array(node[:dnsmasq][:dns][:server]).any? {|ip| ip == '127.0.0.1'}

unless valid_resolv_config
  ruby_block "inconsistent resolvconf configuration" do
    block do
      Chef::Log.error('Resolving will fail since your dnsmasq configuration is inconsistent')
      raise RuntimeError, "Provide external dns servers and enable dns in dnsmasq"
    end
    only_if "which resolvconf"
  end
end

# We stop dnsmasq because resolv configuration is not yet consistent
service 'dnsmasq' do
  only_if "which resolvconf && [ ! -f /etc/dnsmasq.d/dns.conf ]"
  action :stop
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
