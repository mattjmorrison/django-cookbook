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
  include_recipe "apache2::mod_ssl"
  include_recipe "python::virtualenv"

  python_virtualenv "/var/www/base_virtualenv" do
    action :create
  end

  conf_name = 'mod_wsgi'

  template "#{node['apache']['dir']}/conf-available/#{conf_name}.conf" do
    source "mod_wsgi.conf.erb"
    cookbook "django-cookbook"
  end

  apache_config conf_name do
    enable true
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

  if params[:ssl]
    ssl = params[:ssl]
    apache_ssl_wsgi_app "#{name}" do
      ssl ssl
      project name
      wsgi_path wsgi_path
      static_path static_path
      domain domain
      admin_email admin_email
      server_name server_name
    end
  end

end
