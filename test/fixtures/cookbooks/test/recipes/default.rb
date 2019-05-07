apt_update

p = value_for_platform_family(
  %w(rhel fedora suse) => 'bind-utils',
  'debian' => 'dnsutils'
)

package p

include_recipe 'dnsmasq'
