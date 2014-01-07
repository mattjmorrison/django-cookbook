require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe package("apache2") do

  it { should be_installed }

end

describe package("libapache2-mod-wsgi") do

  it { should be_installed }

end

describe file("/etc/apache2/conf.d/mod_wsgi.conf") do

  it { should be_file }

  it { should contain "WSGIPythonHome /var/www/base_virtualenv" }

end

describe file("/etc/apache2/sites-available/sample.conf") do

  it { should be_file }

  it { should contain("<VirtualHost *:80>")}

end

describe file("/etc/apache2/sites-available/sample-ssl.conf") do

  it { should be_file }

  it { should contain("<VirtualHost *:443>")}

  it { should contain("WSGIApplicationGroup %{GLOBAL}").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  it { should contain("WSGIScriptAlias / /var/www/sample/project/wsgi.py").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  it { should contain("WSGIProcessGroup sample-ssl").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  it { should contain("WSGIDaemonProcess sample-ssl processes=2 threads=3 display-name=sample-ssl").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  it { should contain("python-path=/var/www/sample/virtualenv/lib/python2.7/site-packages:/var/www/sample").from(/WSGIDaemonProcess/).to('\n') }
  
end

describe file("/etc/apache2/sites-enabled/sample.conf") do

  it { should be_linked_to '../sites-available/sample.conf' }

end

describe file("/etc/apache2/sites-enabled/sample-ssl.conf") do

  it { should be_linked_to '../sites-available/sample-ssl.conf' }

end
