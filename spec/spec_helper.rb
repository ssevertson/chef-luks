require 'chefspec'
require 'chefspec/berkshelf'
require_relative 'support/matchers'

RSpec.configure do |c|
  c.platform = 'ubuntu'
  c.version = '14.04'
end
