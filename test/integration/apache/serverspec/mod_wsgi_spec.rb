require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe package("libapache2-mod-wsgi") do

  it { should be_installed }

end

describe file("/etc/apache2/conf.d/mod_wsgi.conf") do

  it { should be_file }

  it { should contain "WSGIPythonHome /var/www/base_virtualenv" }

end

