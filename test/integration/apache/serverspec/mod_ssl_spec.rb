require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe file("/etc/apache2/mods-available/ssl.conf") do

  it { should be_file }

  it { should contain('<IfModule mod_ssl.c>').before('</IfModule>') }

  it { should contain('SSLRandomSeed startup builtin').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLRandomSeed startup file:/dev/urandom 512').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLRandomSeed connect builtin').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLRandomSeed connect file:/dev/urandom 512').from('<IfModule').to('</IfModule>') }

  it { should contain('AddType application/x-x509-ca-cert .crt').from('<IfModule').to('</IfModule>') }

  it { should contain('AddType application/x-pkcs7-crl    .crl').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLPassPhraseDialog  builtin').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLSessionCache        shmcb:/var/run/apache2/ssl_scache').from('<IfModule').to('</IfModule>') }
  
  it { should contain('SSLSessionCacheTimeout  300').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLMutex  file:/var/run/apache2/ssl_mutex').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLHonorCipherOrder On').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLCipherSuite RC4-SHA:HIGH:!ADH').from('<IfModule').to('</IfModule>') }

  it { should contain('SSLProtocol all -SSLv2').from('<IfModule').to('</IfModule>') }

end


describe file("/etc/apache2/mods-available/ssl.load") do

  it { should be_file }

  it { should contain("LoadModule ssl_module /usr/lib/apache2/modules/mod_ssl.so") }

end


describe file("/etc/apache2/mods-enabled/ssl.conf") do

  it { should be_linked_to '../mods-available/ssl.conf' }

end


describe file("/etc/apache2/mods-enabled/ssl.load") do

  it { should be_linked_to '../mods-available/ssl.load' }

end
