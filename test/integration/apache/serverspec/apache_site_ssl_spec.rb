require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe file("/etc/apache2/sites-available/dummy-ssl.conf") do

  it { should contain("<VirtualHost *:443>")}
  
end

describe file("/etc/apache2/sites-enabled/dummy-ssl.conf") do

  it { should be_linked_to '../sites-available/dummy-ssl.conf' }

end
