apt_update

p = value_for_platform_family(
  default: 'bind-utils',
  'debian' => 'dnsutils'
)

package p

include_recipe 'dnsmasq'
