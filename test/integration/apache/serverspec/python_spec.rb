require "serverspec"

describe package("virtualenv") do

  it { should be_installed.by("pip") }

end

describe command("/var/www/base_virtualenv/bin/python --version") do

  its(:stdout) { should match "Python 2.7.6" }

end

describe command("/var/www/base_virtualenv/bin/pip freeze") do

  its(:stdout) { should match "" }

end
