require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |c|
  c.platform = 'ubuntu'
  c.version = '14.04'
end
