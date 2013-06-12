require_relative './support/helpers'

describe_recipe 'luks_test::default' do
  include LuksTestHelpers

  it 'should install the required packages for LUKS' do
    package('util-linux').must_be_installed
    package('device-mapper').must_be_installed
    package('cryptsetup-luks').must_be_installed
  end
end
