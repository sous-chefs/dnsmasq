name              'dnsmasq'
maintainer        'Chris Roberts'
maintainer_email  'chrisroberts.code@gmail.com'
license           'Apache-2.0'
description       'Installs and configures dnsmasq'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version      '>= 13.0' if respond_to?(:chef_version)
source_url        'https://github.com/sous-chefs/dnsmasq'
issues_url        'https://github.com/sous-chefs/dnsmasq/issues'
version           '0.2.0'

depends 'hosts_file'

%w(ubuntu debian redhat centos scientific oracle).each do |os|
  supports os
end
