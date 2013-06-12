directory '/mnt/test' do
  action :create
end

execute 'format-luks' do
  action :nothing
  command 'mkfs.ext2 -L luks-test /dev/mapper/luks-test'
end

luks_device '/dev/sdb' do
  action :create
  notifies :run, 'execute[format-luks]', :immediately

  luks_name 'luks-test'
end

mount '/mnt/test' do
  action [:mount, :enable]

  device '/dev/mapper/luks-test'
end
