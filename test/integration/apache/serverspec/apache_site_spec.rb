require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe file("/etc/apache2/sites-available/dummy.conf") do

  it { should contain("<VirtualHost *:80>")}
  
  it { should contain("ServerName dummy1.sample.com:80")}

end

describe file("/etc/apache2/sites-enabled/dummy.conf") do

  it { should be_linked_to '../sites-available/dummy.conf' }

end
