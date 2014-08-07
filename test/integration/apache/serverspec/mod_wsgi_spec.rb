require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe package("libapache2-mod-wsgi") do

  it { should be_installed }

end

describe file("/etc/apache2/conf-available/mod_wsgi.conf") do

  it { should be_file }

  it { should contain "WSGIPythonHome /var/www/base_virtualenv" }

end

describe file("/etc/apache2/conf-enabled/mod_wsgi.conf") do

  it { should be_linked_to '../conf-available/mod_wsgi.conf' }

end

describe file("/etc/apache2/mods-available/wsgi.conf") do

  it { should be_file }

  it { should contain("<IfModule mod_wsgi.c>").before("</IfModule>") }

end

describe file("/etc/apache2/mods-available/wsgi.load") do

  it { should be_file }
  
  it { should contain("LoadModule wsgi_module /usr/lib/apache2/modules/mod_wsgi.so") }

end

describe file("/etc/apache2/mods-enabled/wsgi.conf") do

  it { should be_linked_to '../mods-available/wsgi.conf' }

end

describe file("/etc/apache2/mods-enabled/wsgi.load") do

  it { should be_linked_to '../mods-available/wsgi.load' }

end
