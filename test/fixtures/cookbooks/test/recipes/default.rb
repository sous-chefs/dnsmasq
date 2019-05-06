apt_update

package 'bind-utils' if platform_family?('rhel', 'fedora')

include_recipe 'dnsmasq'
