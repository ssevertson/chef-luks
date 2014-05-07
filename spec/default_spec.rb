require 'chefspec'
require_relative 'spec_helper'
require_relative 'support/matchers'

describe '${COOKBOOK_NAME}::default' do
  let(:chef_run) { ChefSpec::Runner.new do |node|
    node.automatic[:hostname] = 'localhost'
    #node.set[:some_attribute] = 'some_value'
  end.converge(described_recipe) }

  before do
    #stub_data_bag_item(:some_databag, :some_item).and_return({
    #  id: 'some_item',
    #  some_property: 'some_value'
    #})
  end

  #it 'should include a recipe (example)' do
  #  expect(chef_run).to include_recipe('example')
  #end
end
