require 'chefspec'
require 'fauxhai'
require 'berkshelf'

berksfile = Berkshelf::Berksfile.from_file('Berksfile')
#berksfile.install(path: 'vendor/cookbooks')
berksfile.install
