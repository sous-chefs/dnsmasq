# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq_dns' do
  step_into :dnsmasq_dns
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      service 'dnsmasq' do
        action :nothing
      end

      dnsmasq_dns 'default'
    end

    it { is_expected.to create_template('/etc/dnsmasq.d/dns.conf') }
    it { is_expected.to render_file('/etc/dnsmasq.d/dns.conf').with_content(/^no-dhcp-interface=$/) }
    it { is_expected.to render_file('/etc/dnsmasq.d/dns.conf').with_content(/^server=127\.0\.0\.1$/) }
  end

  context 'when dhcp is also enabled' do
    recipe do
      service 'dnsmasq' do
        action :nothing
      end

      dnsmasq_dns 'default' do
        disable_dhcp_interface false
        config('server' => '8.8.8.8')
      end
    end

    it { is_expected.to render_file('/etc/dnsmasq.d/dns.conf').with_content(/^server=8\.8\.8\.8$/) }

    it 'does not render no-dhcp-interface' do
      expect(chef_run).to_not render_file('/etc/dnsmasq.d/dns.conf').with_content(/^no-dhcp-interface=$/)
    end
  end

  context 'action :delete' do
    recipe do
      service 'dnsmasq' do
        action :nothing
      end

      dnsmasq_dns 'default' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/dnsmasq.d/dns.conf') }
  end
end
