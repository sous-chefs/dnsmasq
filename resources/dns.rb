# frozen_string_literal: true

provides :dnsmasq_dns
unified_mode true

use '_partial/_common'

property :config_file, String, default: lazy { ::File.join(config_directory, 'dns.conf') }
property :config, Hash,
         default: { 'no-poll' => nil, 'no-resolv' => nil, 'server' => '127.0.0.1' },
         coerce: proc { |value| value.each_with_object({}) { |(key, inner_value), dns_config| dns_config[key.to_s] = inner_value } }
property :options, [String, Array], default: [], coerce: proc { |value| Array(value) }
property :disable_dhcp_interface, [true, false], default: true

action_class do
  include DnsmasqCookbook::Helpers
end

action :create do
  ensure_service_notification_target(new_resource.service_name)

  directory new_resource.config_directory do
    recursive true
    mode '0755'
  end

  template new_resource.config_file do
    source 'dynamic_config.erb'
    cookbook 'dnsmasq'
    mode new_resource.config_mode
    variables(
      config: dns_config_payload(new_resource.config, new_resource.disable_dhcp_interface),
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
