name              'dnsmasq'
maintainer        'Sous-Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Installs and configures dnsmasq'

chef_version      '>= 15.3'
source_url        'https://github.com/sous-chefs/dnsmasq'
issues_url        'https://github.com/sous-chefs/dnsmasq/issues'
version           '0.3.4'

%w(ubuntu debian redhat centos oracle).each do |os|
  supports os
end
