# frozen_string_literal: true

require 'spec_helper'
require_relative '../libraries/helpers'

describe DnsmasqCookbook::Helpers do
  let(:helper_class) do
    Class.new do
      include DnsmasqCookbook::Helpers

      attr_accessor :node

      def platform?(name)
        Array(name).include?(node['platform'])
      end

      def data_bag_item(_bag, _item)
        raise Chef::Exceptions::InvalidDataBagPath, 'not found'
      end
    end
  end

  let(:helper) { helper_class.new }

  before do
    helper.node = {
      'platform' => 'ubuntu',
      'platform_family' => 'debian',
      'platform_version' => '24.04',
    }
  end

  describe '#normalize_config' do
    it 'coerces symbol keys to strings via to_s' do
      result = helper.normalize_config(server: '127.0.0.1')
      expect(result).to eq('server' => '127.0.0.1')
    end

    it 'leaves string keys unchanged' do
      result = helper.normalize_config('no-poll' => nil, 'server' => '8.8.8.8')
      expect(result).to eq('no-poll' => nil, 'server' => '8.8.8.8')
    end

    it 'preserves nil values' do
      result = helper.normalize_config('no-poll' => nil)
      expect(result['no-poll']).to be_nil
    end
  end

  describe '#dns_config_payload' do
    context 'when disable_dhcp_interface is true' do
      it 'adds the no-dhcp-interface= key' do
        result = helper.dns_config_payload({ 'server' => '127.0.0.1' }, true)
        expect(result).to include('no-dhcp-interface=' => nil)
      end
    end

    context 'when disable_dhcp_interface is false' do
      it 'does not add the no-dhcp-interface= key' do
        result = helper.dns_config_payload({ 'server' => '127.0.0.1' }, false)
        expect(result).not_to have_key('no-dhcp-interface=')
      end
    end
  end

  describe '#normalize_managed_hosts' do
    it 'converts an Array value to a list of strings' do
      result = helper.normalize_managed_hosts('10.0.0.1' => ['router.test.lab', 'router'])
      expect(result).to eq('10.0.0.1' => ['router.test.lab', 'router'])
    end

    it 'splits a space-delimited String value into an array' do
      result = helper.normalize_managed_hosts('10.0.0.2' => 'printer.test.lab printer')
      expect(result).to eq('10.0.0.2' => ['printer.test.lab', 'printer'])
    end

    it 'coerces IP keys to strings' do
      result = helper.normalize_managed_hosts('10.0.0.3': ['host.test.lab'])
      expect(result.keys).to eq(['10.0.0.3'])
    end

    it 'compacts nil entries from Array values' do
      result = helper.normalize_managed_hosts('10.0.0.4' => ['host.test.lab', nil])
      expect(result['10.0.0.4']).to eq(['host.test.lab'])
    end
  end

  describe '#load_managed_hosts' do
    context 'with explicit entries only (data bag disabled)' do
      it 'returns normalized entries' do
        result = helper.load_managed_hosts(
          entries: { '10.0.0.10' => ['gw.test.lab', 'gw'] },
          data_bag_name: false,
          data_bag_item_name: false
        )
        expect(result).to eq('10.0.0.10' => ['gw.test.lab', 'gw'])
      end
    end

    context 'when the data bag is missing' do
      it 'falls back to explicit entries without raising' do
        result = helper.load_managed_hosts(
          entries: { '10.0.0.11' => ['host.test.lab'] },
          data_bag_name: 'dnsmasq',
          data_bag_item_name: 'managed_hosts'
        )
        expect(result).to eq('10.0.0.11' => ['host.test.lab'])
      end
    end
  end

  describe '#default_manage_systemd_resolved?' do
    context 'on Ubuntu' do
      it 'returns true' do
        expect(helper.default_manage_systemd_resolved?).to be true
      end
    end

    context 'on Debian' do
      before { helper.node = helper.node.merge('platform' => 'debian') }

      it 'returns false' do
        expect(helper.default_manage_systemd_resolved?).to be false
      end
    end

    context 'on AlmaLinux' do
      before { helper.node = helper.node.merge('platform' => 'almalinux') }

      it 'returns false' do
        expect(helper.default_manage_systemd_resolved?).to be false
      end
    end
  end
end
