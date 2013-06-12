actions :create, :delete
default_action :create

attribute :block_device, :name_attribute => true,
  :kind_of => String, :required => true

attribute :key_file, :kind_of => String,
  :default => Chef::Config[:encrypted_data_bag_secret],
  :required => true

attribute :luks_name, :kind_of => String,
  :required => true


attr_accessor :exists
