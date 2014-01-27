require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe file("/etc/apache2/sites-available/sample-ssl.conf") do

  it { should contain("<VirtualHost *:443>")}
  
end

describe file("/etc/apache2/sites-enabled/sample-ssl.conf") do

  it { should be_linked_to '../sites-available/sample-ssl.conf' }

end
