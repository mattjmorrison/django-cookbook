require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe file("/etc/apache2/sites-available/dummy.conf") do

  it { should contain("<VirtualHost *:80>")}
  
  it { should contain("ServerName dummy1.sample.com:80")}

  it { should contain("ErrorLog /var/log/apache2/dummy-error.log").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  it { should contain("CustomLog /var/log/apache2/dummy-combined.log combined").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  it { should_not contain("SSLEngine on") }

end

describe file("/etc/apache2/sites-enabled/dummy.conf") do

  it { should be_linked_to '../sites-available/dummy.conf' }

end
