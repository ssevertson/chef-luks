require_relative './support/helpers'

describe_recipe 'luks_test::default' do
  include LuksTestHelpers

  it 'should install the required packages for LUKS on rhel' do
    unless node['platform_family'] == 'rhel' || node['platform_family'] == 'fedora'
      skip 'Only applicable on RHEL/Fedora family'
    end
    package('util-linux').must_be_installed
    package('device-mapper').must_be_installed
    package('cryptsetup-luks').must_be_installed
  end

  it 'should install the required packages for LUKS on debian' do
    unless node['platform_family'] == 'debian'
      skip 'Only applicable on Debian family'
    end
    package('util-linux').must_be_installed
    package('dmsetup').must_be_installed
    package('cryptsetup').must_be_installed
  end
end
