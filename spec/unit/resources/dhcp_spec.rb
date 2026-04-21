# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq_dhcp' do
  step_into :dnsmasq_dhcp
  platform 'ubuntu', '24.04'

  recipe do
    service 'dnsmasq' do
      action :nothing
    end

    dnsmasq_dhcp 'default' do
      options ['dhcp-host=01:23:ab:cd:01:02,larry,10.0.0.10']
      config(
        'dhcp-range' => 'eth1,10.0.0.5,10.0.0.15,12h',
        'domain' => 'test.lab',
        'tftp-root' => '/var/lib/tftpboot',
        'enable-tftp' => nil,
        'interface' => 'eth1'
      )
    end
  end

  it { is_expected.to create_directory('/var/lib/tftpboot').with(owner: 'dnsmasq') }
  it { is_expected.to create_template('/etc/dnsmasq.d/dhcp.conf') }
  it { is_expected.to render_file('/etc/dnsmasq.d/dhcp.conf').with_content(/^dhcp-range=eth1,10\.0\.0\.5,10\.0\.0\.15,12h$/) }
  it { is_expected.to render_file('/etc/dnsmasq.d/dhcp.conf').with_content(/^dhcp-host=01:23:ab:cd:01:02,larry,10\.0\.0\.10$/) }
end
