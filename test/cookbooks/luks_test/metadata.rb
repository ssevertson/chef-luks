name             'luks_test'
maintainer       'Intoximeters, Inc'
maintainer_email 'devops@intoxitrack.net'
license          'Apache 2.0'
description      'Installs/Configures luks_test'
version          '0.0.1'

%w{centos redhat scientific fedora amazon}.each do |os|
  supports os
end

depends 'luks'
