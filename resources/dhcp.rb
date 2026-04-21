# frozen_string_literal: true

provides :dnsmasq_dhcp
unified_mode true

use '_partial/_common'

property :user, String, default: 'dnsmasq'
property :config_file, String, default: lazy { ::File.join(config_directory, 'dhcp.conf') }
property :config, Hash,
         default: {},
         coerce: proc { |value| value.each_with_object({}) { |(key, inner_value), dhcp_config| dhcp_config[key.to_s] = inner_value } }
property :options, [String, Array], default: [], coerce: proc { |value| Array(value) }

action_class do
  include DnsmasqCookbook::Helpers
end

action :create do
  ensure_service_notification_target(new_resource.service_name)

  directory new_resource.config_directory do
    recursive true
    mode '0755'
  end

  if new_resource.config['tftp-root']
    directory new_resource.config['tftp-root'] do
      owner new_resource.user
      recursive true
      mode '0755'
    end
  end

  template new_resource.config_file do
    source 'dynamic_config.erb'
    cookbook 'dnsmasq'
    mode new_resource.config_mode
    variables(
      config: new_resource.config,
      list: new_resource.options
    )
    notifies :restart, "service[#{new_resource.service_name}]", :delayed
  end
end

action :delete do
  ensure_service_notification_target(new_resource.service_name)

  file new_resource.config_file do
    action :delete
    notifies :restart, "service[#{new_resource.service_name}]", :delayed
  end
end
