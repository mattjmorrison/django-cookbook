require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS


describe file("/etc/apache2/mods-available/ssl.conf") do

  it { should be_file }

  # <IfModule mod_ssl.c>
  # SSLRandomSeed startup builtin
  # SSLRandomSeed startup file:/dev/urandom 512
  # SSLRandomSeed connect builtin
  # SSLRandomSeed connect file:/dev/urandom 512

  # AddType application/x-x509-ca-cert .crt
  # AddType application/x-pkcs7-crl    .crl

  # SSLPassPhraseDialog  builtin

  # SSLSessionCache        shmcb:/var/run/apache2/ssl_scache
  # SSLSessionCacheTimeout  300

  # SSLMutex  file:/var/run/apache2/ssl_mutex

  # SSLHonorCipherOrder On
  # SSLCipherSuite RC4-SHA:HIGH:!ADH

  # SSLProtocol all -SSLv2
# </IfModule>

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
