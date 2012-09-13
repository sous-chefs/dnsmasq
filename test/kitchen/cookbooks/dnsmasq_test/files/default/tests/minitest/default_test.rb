require_relative './helpers.rb'

describe_recipe 'dnsmasq_test::default' do
  include DnsMasqTestHelper

  describe 'dnsmaq' do
    it 'should start dnsmasq' do
      service('dnsmasq').must_be_enabled
      service('dnsmasq').must_be_running
    end

    it 'should be managing the hosts file' do
      file(node[:hosts_file][:path]).must_exist
      file(node[:hosts_file][:path]).must_match /Hosts file managed by Chef/
    end

    it 'should have dnsmasq instance running' do
      service('dnsmasq').must_be_enabled
      service('dnsmasq').must_be_running
    end

    it 'should return the expected address from /etc/hosts' do
      refute_nil(
        `host www.google.com 127.0.0.1`.split("\n").detect{|l| l.include?('192.168.0.2')},
        'Received invalid address when looking up www.google.com'
      )
    end
  end

end
