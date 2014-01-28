require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe package("apache2") do

  it { should be_installed }

end

["dummy-ssl", "dummy"].each do |site|
  describe file("/etc/apache2/sites-available/#{site}.conf") do

    it { should be_file }

    it { should contain("WSGIApplicationGroup %{GLOBAL}").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

    it { should contain("WSGIScriptAlias / /var/www/dummy/wsgi/main.wsgi").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

    it { should contain("WSGIProcessGroup #{site}").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

    it { should contain("WSGIDaemonProcess #{site} processes=2 threads=3 display-name=#{site}").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

    it { should contain("python-path=/var/www/dummy/virtualenv/lib/python2.7/site-packages:/var/www/dummy").from(/WSGIDaemonProcess/).to('\n') }

    it { should contain("Alias /static/ /var/www/dummy/static/").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  end
end

["dummy2-ssl", "dummy2"].each do |site|
  describe file("/etc/apache2/sites-available/#{site}.conf") do

    it { should be_file }

    it { should contain("Alias /static/ /var/www/dummy2/static/").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  end
end
