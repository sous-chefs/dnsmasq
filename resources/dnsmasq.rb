# frozen_string_literal: true

provides :dnsmasq
unified_mode true

use '_partial/_common'

property :package_name, String, default: 'dnsmasq'
property :user, String, default: 'dnsmasq'
property :enable_dns, [true, false], default: true
property :dns_config, Hash,
         default: { 'no-poll' => nil, 'no-resolv' => nil, 'server' => '127.0.0.1' },
         coerce: proc { |value| value.each_with_object({}) { |(key, inner_value), config| config[key.to_s] = inner_value } }
property :dns_options, [String, Array], default: [], coerce: proc { |value| Array(value) }
property :enable_dhcp, [true, false], default: false
property :dhcp_config, Hash,
         default: {},
         coerce: proc { |value| value.each_with_object({}) { |(key, inner_value), config| config[key.to_s] = inner_value } }
property :dhcp_options, [String, Array], default: [], coerce: proc { |value| Array(value) }
property :managed_hosts, Hash,
         default: {},
         coerce: proc { |value| value.each_with_object({}) { |(key, inner_value), hosts| hosts[key.to_s] = inner_value } }
property :managed_hosts_data_bag, [String, NilClass, FalseClass], default: 'dnsmasq'
property :managed_hosts_data_bag_item, [String, NilClass, FalseClass], default: 'managed_hosts'
property :manage_systemd_resolved, [true, false, nil], default: nil

action_class do
  include DnsmasqCookbook::Helpers
end

action :create do
  manage_systemd_resolved = if new_resource.manage_systemd_resolved.nil?
                              default_manage_systemd_resolved?
                            else
                              new_resource.manage_systemd_resolved
                            end

  if manage_systemd_resolved
    service 'systemd-resolved' do
      action :nothing
    end

    directory '/etc/systemd/resolved.conf.d' do
      recursive true
      mode '0755'
    end

    file '/etc/systemd/resolved.conf.d/dnsmasq.conf' do
      content "[Resolve]\nDNSStubListener=no\n"
      mode '0644'
      notifies :restart, 'service[systemd-resolved]', :immediately
    end
  end

  package new_resource.package_name

  user new_resource.user do
    system true
  end

  directory new_resource.config_directory do
    recursive true
    mode '0755'
  end

  if new_resource.enable_dns
    dnsmasq_dns new_resource.name do
      config_directory new_resource.config_directory
      config_mode new_resource.config_mode
      service_name new_resource.service_name
      config new_resource.dns_config
      options new_resource.dns_options
      disable_dhcp_interface !new_resource.enable_dhcp
    end

    dnsmasq_managed_hosts new_resource.name do
      service_name new_resource.service_name
      entries new_resource.managed_hosts
      data_bag new_resource.managed_hosts_data_bag
      data_bag_item new_resource.managed_hosts_data_bag_item
    end
  else
    file ::File.join(new_resource.config_directory, 'dns.conf') do
      action :delete
      notifies :restart, "service[#{new_resource.service_name}]", :delayed
    end
  end

  if new_resource.enable_dhcp
    dnsmasq_dhcp new_resource.name do
      config_directory new_resource.config_directory
      config_mode new_resource.config_mode
      service_name new_resource.service_name
      user new_resource.user
      config new_resource.dhcp_config
      options new_resource.dhcp_options
    end
  else
    file ::File.join(new_resource.config_directory, 'dhcp.conf') do
      action :delete
      notifies :restart, "service[#{new_resource.service_name}]", :delayed
    end
  end

  service new_resource.service_name do
    action %i(enable start)
  end
end
