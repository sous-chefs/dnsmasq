require_relative './helpers.rb'

describe_recipe 'dnsmasq_test::default' do
  include DnsMasqTestHelper

  describe 'dnsmaq' do
    it 'should start dnsmasq' do
      service('dnsmasq').must_be_enabled
      service('dnsmasq').must_be_running
    end

    it 'should have the right dhcp config file' do
      file('/etc/dnsmasq.d/dhcp.conf').must_have(:mode, '644')
      file('/etc/dnsmasq.d/dhcp.conf').must_match /^dhcp-host=01:23:ab:cd:01:02,larry,10\.0\.0\.10$/
      file('/etc/dnsmasq.d/dhcp.conf').must_match /^dhcp-range=eth1,10\.0\.0\.5,10\.0\.0\.15,12h$/
      file('/etc/dnsmasq.d/dhcp.conf').must_match /^domain=test.lab$/
      file('/etc/dnsmasq.d/dhcp.conf').must_match /^enable-tftp$/
      file('/etc/dnsmasq.d/dhcp.conf').must_match /^interface=eth1$/
      file('/etc/dnsmasq.d/dhcp.conf').must_match /^tftp-root=\/var\/lib\/tftpboot$/
    end

    it 'should have the right dns config file' do
      file('/etc/dnsmasq.d/dns.conf').must_have(:mode, '644')
      file('/etc/dnsmasq.d/dns.conf').must_match /^no-poll$/
      file('/etc/dnsmasq.d/dns.conf').must_match /^no-resolv$/
      file('/etc/dnsmasq.d/dns.conf').must_match /^server=127\.0\.0\.1$/
    end

  end

end
