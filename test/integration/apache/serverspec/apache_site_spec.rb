require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe file("/etc/apache2/sites-available/sample.conf") do

  it { should contain("<VirtualHost *:80>")}
  
end

describe file("/etc/apache2/sites-enabled/sample.conf") do

  it { should be_linked_to '../sites-available/sample.conf' }

end
