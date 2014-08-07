require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe package("virtualenv") do

  it { should be_installed.by("pip") }

end

describe command("/var/www/base_virtualenv/bin/python --version") do
  
  it { should return_stdout "Python 2.7.6" }

end

describe command("/var/www/base_virtualenv/bin/pip freeze") do

  it { should return_stdout "argparse==1.2.1\nwsgiref==0.1.2" }

end
