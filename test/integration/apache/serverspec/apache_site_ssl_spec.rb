require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe file("/etc/apache2/sites-available/dummy-ssl.conf") do

  it { should contain("<VirtualHost *:443>")}

  it { should contain("ServerName dummy1.sample.com:443")}

  it { should contain("ErrorLog /var/log/apache2/dummy-ssl-error.log").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  it { should contain("CustomLog /var/log/apache2/dummy-ssl-combined.log combined").from(/<VirtualHost/).to(/<\/VirtualHost>/) }

  it { should contain("SSLEngine on") }

  it { should contain("SSLCipherSuite ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP:+eNULL") }

  it { should contain("SSLCertificateFile /etc/ssl/private/fake.crt") }

  it { should contain("SSLCertificateKeyFile /etc/ssl/private/fake.key") }

  it { should contain("SSLCertificateChainFile /etc/ssl/private/fake.crt") }

  it { should contain('BrowserMatch ".*MSIE.*" nokeepalive ssl-unclean-shutdown downgrade-1.0 force-response-1.0') }

end


describe file("/etc/apache2/sites-enabled/dummy-ssl.conf") do

  it { should be_linked_to '../sites-available/dummy-ssl.conf' }

end
