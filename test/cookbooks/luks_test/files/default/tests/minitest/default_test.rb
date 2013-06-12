require_relative './support/helpers'

describe_recipe 'luks_test::default' do
  include LuksTestHelpers

  it 'should install the cryptsetup-luks package' do
    package('cryptsetup-luks').must_be_installed
  end
end
