# frozen_string_literal: true

module DnsmasqCookbook
  module Helpers
    def normalize_config(value)
      value.each_with_object({}) do |(key, inner_value), config|
        config[key.to_s] = inner_value
      end
    end

    def dns_config_payload(config, disable_dhcp_interface)
      payload = normalize_config(config)
      payload['no-dhcp-interface='] = nil if disable_dhcp_interface
      payload
    end

    def normalize_managed_hosts(entries)
      entries.each_with_object({}) do |(ip, hostnames), normalized|
        names = case hostnames
                when Array
                  hostnames.compact.map(&:to_s)
                else
                  hostnames.to_s.split
                end

        normalized[ip.to_s] = names
      end
    end

    def load_managed_hosts(entries:, data_bag_name:, data_bag_item_name:)
      combined_entries = {}

      if data_bag_name && data_bag_item_name
        begin
          data_bag = data_bag_item(data_bag_name, data_bag_item_name)
          combined_entries.merge!(data_bag['maps']) if data_bag['maps']
        rescue StandardError => e
          Chef::Log.debug("Unable to load dnsmasq managed hosts data bag item #{data_bag_name}/#{data_bag_item_name}: #{e.message}")
        end
      end

      combined_entries.merge!(entries)
      normalize_managed_hosts(combined_entries)
    end

    def ensure_service_notification_target(service_name)
      run_context.resource_collection.lookup("service[#{service_name}]")
    rescue Chef::Exceptions::ResourceNotFound
      declare_resource(:service, service_name) do
        action :nothing
      end
    end

    def default_manage_systemd_resolved?
      platform?('ubuntu') && node['platform_version'].to_f >= 18.04
    end
  end
end
