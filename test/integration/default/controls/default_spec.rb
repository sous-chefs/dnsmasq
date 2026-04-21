# frozen_string_literal: true

control 'dnsmasq-service-01' do
  impact 1.0
  title 'dnsmasq service is enabled and running'

  describe systemd_service('dnsmasq') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'dnsmasq-package-01' do
  impact 1.0
  title 'dnsmasq package is installed'

  describe package('dnsmasq') do
    it { should be_installed }
  end
end

control 'dnsmasq-directory-01' do
  impact 0.7
  title 'dnsmasq config directory exists'

  describe directory('/etc/dnsmasq.d') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
end

control 'dnsmasq-config-01' do
  impact 1.0
  title 'dnsmasq configuration files are rendered from custom resources'

  describe file('/etc/dnsmasq.d/dhcp.conf') do
    it { should exist }
    its('content') { should match(/^dhcp-host=01:23:ab:cd:01:02,larry,10\.0\.0\.10$/) }
    its('content') { should match(/^dhcp-range=10\.0\.0\.5,10\.0\.0\.15,12h$/) }
    its('content') { should match(/^domain=test.lab$/) }
    its('content') { should match(/^enable-tftp$/) }
    its('content') { should match(/^except-interface=lo$/) }
    its('content') { should match(%r{^tftp-root=/var/lib/tftpboot$}) }
  end

  describe file('/etc/dnsmasq.d/dns.conf') do
    it { should exist }
    its('content') { should match(/^no-poll$/) }
    its('content') { should match(/^no-resolv$/) }
    its('content') { should match(/^server=8\.8\.8\.8$/) }
    its('content') { should_not match(/^no-dhcp-interface=$/) }
  end
end

control 'dnsmasq-hosts-01' do
  impact 0.7
  title 'managed hosts entries are present'

  describe file('/etc/hosts') do
    its('content') { should match(/^10\.0\.0\.20\s+router\.test\.lab\s+router(?:\s+# dnsmasq managed entry)?$/) }
  end
end

control 'dnsmasq-dns-01' do
  impact 0.7
  title 'dnsmasq answers DNS requests'

  describe command('host google.com') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/^google.com has address/) }
  end

  describe port(53) do
    it { should be_listening }
  end
end
