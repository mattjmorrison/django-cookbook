include_recipe "apache2::mod_wsgi"
include_recipe "python::virtualenv"

python_virtualenv "/var/www/base_virtualenv" do
  action :create
end

template "#{node['apache']['dir']}/conf.d/mod_wsgi.conf" do
  source "mod_wsgi.conf.erb"
end

web_app "sample" do
  template "sample.erb"
  port 80
end

web_app "sample-ssl" do
  template "sample.erb"
  port 443
end
