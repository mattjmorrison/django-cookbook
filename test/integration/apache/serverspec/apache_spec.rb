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

    it { should contain("<Directory /var/www/dummy/static/ >").from(/<VirtualHost/).to(/<\/VirtualHost>/)}

    it { should contain("</Directory>").from(/<Directory/).to(/<\/VirtualHost>/)}

    it { should contain("Options FollowSymLinks MultiViews ExecCGI").from(/<Directory/).to(/<\/Directory>/) }

    it { should contain("AllowOverride None").from(/<Directory/).to(/<\/Directory>/) }

    it { should contain("Order deny,allow").from(/<Directory/).to(/<\/Directory>/) }

    it { should contain("Deny from all").from(/<Directory/).to(/<\/Directory>/) }

    it { should contain("SetEnvIfNoCase Host sample.com VALID_HOST").from(/<Directory/).to(/<\/Directory>/) }

    it { should contain("Allow from env=VALID_HOST").from(/<Directory/).to(/<\/Directory>/) }

    it { should contain("ServerAdmin dummy@dummy.com").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

    it { should contain("ServerAlias sample.com").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

    it { should contain("LogLevel warn").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

    # MISC STUFF =======
    # <% if @app[:server_aliases] %>ServerAlias <%= @app[:server_aliases] %><% end %>
    # DocumentRoot static_path
    # <Directory wsgi_path>
    #     Options FollowSymLinks MultiViews ExecCGI
    #     AllowOverride None
    #     SetEnvIfNoCase Host <%= @app[:domain] %> VALID_HOST
    #     Order deny,allow
    #     Deny from all
    #     Allow from env=VALID_HOST
    # </Directory>

  end
end

describe file("/etc/apache2/sites-available/dummy2.conf") do

    it { should be_file }

    it { should contain("Alias /static/ /var/www/dummy2/static/").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

    it { should contain("<Directory /var/www/dummy2/static/ >").from(/<VirtualHost/).to(/<\/VirtualHost>/)}

end
