control 'service' do
  describe service('dnsmasq') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'configuration' do
  describe file('/etc/dnsmasq.d/dhcp.conf') do
    it { should be_mode '644' }
    its(:content) { should match(/^dhcp-host=01:23:ab:cd:01:02,larry,10\.0\.0\.10$/) }
    its(:content) { should match(/^dhcp-range=eth1,10\.0\.0\.5,10\.0\.0\.15,12h$/) }
    its(:content) { should match(/^domain=test.lab$/) }
    its(:content) { should match(/^enable-tftp$/) }
    its(:content) { should match(/^interface=eth1$/) }
    its(:content) { should match(%r{^tftp-root=\/var\/lib\/tftpboot$}) }
  end

  describe file('/etc/dnsmasq.d/dns.conf') do
    it { should be_mode '644' }
    its(:content) { should match(/^no-poll$/) }
    its(:content) { should match(/^no-resolv$/) }
    its(:content) { should match(/^server=8\.8\.8\.8$/) }
  end
end

control 'dns resolution' do
  describe command('host google.com') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/^google.com has address/) }
  end
end

control 'dns port' do
  describe port(53) do
    it { should be_listening }
  end
end

control 'bootp/dhcp' do
  describe port(67) do
    it { should be_listening }
  end
end

control 'tftp' do
  describe port(69) do
    it { should be_listening }
  end
end
