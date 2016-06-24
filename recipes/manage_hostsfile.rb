begin
  managed_hosts_bag = data_bag_item('dnsmasq', node['dnsmasq']['managed_hosts_bag'])
rescue
  Chef::Log.debug 'No data bag found for DNSMasq managed hosts file'
end

managed_hosts = {}
managed_hosts.merge!(managed_hosts_bag['maps']) if managed_hosts_bag
managed_hosts.merge!(node['dnsmasq']['managed_hosts'].to_hash) if node['dnsmasq']['managed_hosts']

managed_hosts.each do |ip, host|
  host = host.is_a?(Array) ? host.join(' ') : host
  hostsfile_entry ip do
    hostname host
    unique   false
    notifies :restart, 'service[dnsmasq]', :delayed
    action   :create
  end
end
