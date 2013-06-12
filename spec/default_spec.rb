require 'spec_helper'

describe 'luks::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge('luks::default') }

  it 'should install the correct packages' do
    chef_run.should install_package 'cryptsetup-luks'
  end
end
