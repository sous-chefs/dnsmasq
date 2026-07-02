# frozen_string_literal: true

name 'dnsmasq'

run_list 'test::default'

cookbook 'dnsmasq', path: '.'
cookbook 'hostsfile', git: 'https://github.com/customink-webops/hostsfile.git', branch: 'master'
cookbook 'test', path: './test/cookbooks/test'

Dir.children('./test/cookbooks/test/recipes').grep(/\.rb\z/).sort.each do |recipe|
  recipe_name = File.basename(recipe, '.rb')

  named_run_list recipe_name.to_sym, "test::#{recipe_name}"
end
