# frozen_string_literal: true

provides :dnsmasq_managed_hosts
unified_mode true

use '_partial/_common'

property :entries, Hash,
         default: {},
         coerce: proc { |value| value.each_with_object({}) { |(key, inner_value), hosts| hosts[key.to_s] = inner_value } }
property :data_bag, [String, NilClass, FalseClass], default: 'dnsmasq'
property :data_bag_item, [String, NilClass, FalseClass], default: 'managed_hosts'
property :comment, String, default: 'dnsmasq managed entry'

action_class do
  include DnsmasqCookbook::Helpers
end

action :create do
  ensure_service_notification_target(new_resource.service_name)

  load_managed_hosts(
    entries: new_resource.entries,
    data_bag_name: new_resource.data_bag,
    data_bag_item_name: new_resource.data_bag_item
  ).each do |ip, hostnames|
    next if hostnames.empty?

    hostsfile_entry ip do
      hostname hostnames.first
      aliases hostnames.drop(1) unless hostnames.length == 1
      comment new_resource.comment
      notifies :restart, "service[#{new_resource.service_name}]", :delayed
    end
  end
end

action :delete do
  ensure_service_notification_target(new_resource.service_name)

  load_managed_hosts(
    entries: new_resource.entries,
    data_bag_name: new_resource.data_bag,
    data_bag_item_name: new_resource.data_bag_item
  ).each_key do |ip|
    hostsfile_entry ip do
      action :remove
      comment new_resource.comment
      notifies :restart, "service[#{new_resource.service_name}]", :delayed
    end
  end
end
