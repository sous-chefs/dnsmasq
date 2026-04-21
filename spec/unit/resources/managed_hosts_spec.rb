# frozen_string_literal: true

require 'spec_helper'

describe 'dnsmasq_managed_hosts' do
  step_into :dnsmasq_managed_hosts
  platform 'ubuntu', '24.04'

  recipe do
    service 'dnsmasq' do
      action :nothing
    end

    dnsmasq_managed_hosts 'default' do
      data_bag false
      entries(
        '10.0.0.20' => ['router.test.lab', 'router'],
        '10.0.0.21' => 'printer.test.lab printer'
      )
    end
  end

  it do
    expect(chef_run).to create_hostsfile_entry('10.0.0.20').with(
      hostname: 'router.test.lab',
      aliases: ['router'],
      comment: 'dnsmasq managed entry'
    )
  end

  it do
    expect(chef_run).to create_hostsfile_entry('10.0.0.21').with(
      hostname: 'printer.test.lab',
      aliases: ['printer'],
      comment: 'dnsmasq managed entry'
    )
  end
end
