execute 'apt-get update' if platform_family?('debian')
package 'bind-utils' if platform_family?('rhel', 'fedora')
include_recipe 'dnsmasq'
