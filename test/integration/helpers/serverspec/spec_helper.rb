require 'serverspec'

set :backend, :exec

# add /sbin to path for centos-5.11 platform
set :path, '/sbin:$PATH'
