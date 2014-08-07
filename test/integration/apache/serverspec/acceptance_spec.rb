require "serverspec"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe command('wget -qO - http://dummy1.sample.com') do

  it { should return_stdout "Hello World from dummy!" }

end

describe command('wget -O - https://dummy1.sample.com') do

  its(:stdout) { should match "Self-signed certificate encountered." }

end

describe command('wget -qO - https://dummy1.sample.com --no-check-certificate') do

  it { should return_stdout "Hello World from dummy!" }

end

describe command('wget -qO - http://dummy2.sample.com') do

  it { should return_stdout "Hello World from dummy2!" }

end
