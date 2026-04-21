# frozen_string_literal: true

name              'dnsmasq'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Provides dnsmasq custom resources for install, DNS, DHCP, and managed hosts'

chef_version      '>= 16.0'
source_url        'https://github.com/sous-chefs/dnsmasq'
issues_url        'https://github.com/sous-chefs/dnsmasq/issues'
version           '1.1.15'

depends 'hostsfile'

supports 'almalinux', '>= 9.0'
supports 'amazon', '>= 2023.0'
supports 'centos_stream', '>= 9.0'
supports 'debian', '>= 12.0'
supports 'fedora'
supports 'oracle', '>= 8.0'
supports 'redhat', '>= 8.0'
supports 'rocky', '>= 9.0'
supports 'ubuntu', '>= 22.04'
