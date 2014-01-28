define :apache_wsgi_app do
  name = params[:name]
  wsgi_path = params[:wsgi_path]
  server_name = params[:server_name]
  admin_email = params[:admin_email]
  static_path = params[:static_path]
  static_path += '/' unless params[:static_path][-1, 1] == '/'

  chef_gem 'public_suffix' do
    version '1.3.1'
  end
  require 'public_suffix'
  domain = PublicSuffix.parse(server_name).domain

  include_recipe "apache2::mod_wsgi"
  include_recipe "python::virtualenv"

  python_virtualenv "/var/www/base_virtualenv" do
    action :create
  end

  template "#{node['apache']['dir']}/conf.d/mod_wsgi.conf" do
    source "mod_wsgi.conf.erb"
    cookbook "django-cookbook"
  end

  web_app name do
    template "site.erb"
    cookbook "django-cookbook"
    port 80
    project name
    wsgi_path wsgi_path
    static_path static_path
    domain domain
    admin_email admin_email
    server_name server_name
  end

  web_app "#{name}-ssl" do
    template "site.erb"
    cookbook "django-cookbook"
    port 443
    project name
    wsgi_path wsgi_path
    static_path static_path
    domain domain
    admin_email admin_email
    server_name server_name
  end

end
