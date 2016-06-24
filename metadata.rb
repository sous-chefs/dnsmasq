name 'dnsmasq'
maintainer 'Chris Roberts'
maintainer_email 'chrisroberts.code@gmail.com'
license 'Apache 2.0'
description 'Installs and configures dnsmasq'
version '0.2.0'

depends 'hostsfile'

%w(ubuntu debian redhat centos scientific oracle).each do |os|
  supports os
end
