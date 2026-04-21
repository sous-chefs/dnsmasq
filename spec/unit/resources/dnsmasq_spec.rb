# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq' do
  step_into :dnsmasq, :dnsmasq_dns, :dnsmasq_dhcp, :dnsmasq_managed_hosts
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      dnsmasq 'default' do
        managed_hosts_data_bag false
      end
    end

    it { is_expected.to install_package('dnsmasq') }
    it { is_expected.to create_user('dnsmasq').with(system: true) }
    it { is_expected.to create_directory('/etc/dnsmasq.d') }
    it { is_expected.to enable_service('dnsmasq') }
    it { is_expected.to start_service('dnsmasq') }
    it { is_expected.to create_template('/etc/dnsmasq.d/dns.conf') }
    it { is_expected.to delete_file('/etc/dnsmasq.d/dhcp.conf') }
  end

  context 'with dhcp and managed hosts enabled' do
    recipe do
      dnsmasq 'default' do
        managed_hosts_data_bag false
        enable_dhcp true
        managed_hosts('10.0.0.20' => ['router.test.lab', 'router'])
        dhcp_options ['dhcp-host=01:23:ab:cd:01:02,larry,10.0.0.10']
        dhcp_config(
          'dhcp-range' => 'eth1,10.0.0.5,10.0.0.15,12h',
          'domain' => 'test.lab',
          'tftp-root' => '/var/lib/tftpboot',
          'enable-tftp' => nil,
          'interface' => 'eth1'
        )
      end
    end

    it { is_expected.to create_template('/etc/dnsmasq.d/dhcp.conf') }
    it { is_expected.to create_directory('/var/lib/tftpboot').with(owner: 'dnsmasq') }
    it { is_expected.to create_hostsfile_entry('10.0.0.20') }

    it 'does not render no-dhcp-interface when dhcp is enabled' do
      expect(chef_run).to_not render_file('/etc/dnsmasq.d/dns.conf').with_content(/^no-dhcp-interface=$/)
    end
  end
end
