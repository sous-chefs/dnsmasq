package 'dnsmasq'

include_recipe 'dnsmasq::dns' if node['dnsmasq']['enable_dns']
include_recipe 'dnsmasq::dhcp' if node['dnsmasq']['enable_dhcp']

# Keep defaults for the package installed in the system (normally
# a fully commented file), but make sure that conf-dir is set
existingconf = Hash[File.readlines('/etc/dnsmasq.conf').select { |l| /^[^#\n]/.match(l) }.map { |l| l.strip.split '=' }]
existingconf['conf-dir'] = '/etc/dnsmasq.d'

template '/etc/dnsmasq.conf' do
  source 'dynamic_config.erb'
  mode 0644
  variables(
    :config => existingconf,
    :list   => nil
  )
end

service 'dnsmasq' do
  action [:enable, :start]
end
