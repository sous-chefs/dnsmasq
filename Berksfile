site :opscode

metadata

cookbook "hosts_file"

group :integration do
  cookbook "minitest-handler"
  cookbook "apt"
  cookbook "dnsmasq_test", :path => "./test/cookbooks/dnsmasq_test"
end
