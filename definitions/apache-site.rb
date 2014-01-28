define :apache_wsgi_app do
  name = params[:name]
  wsgi_path = params[:wsgi_path]
  domain = params[:domain]
  static_path = params[:static_path]
  static_path += '/' unless params[:static_path][-1, 1] == '/'

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
  end

  web_app "#{name}-ssl" do
    template "site.erb"
    cookbook "django-cookbook"
    port 443
    project name
    wsgi_path wsgi_path
    static_path static_path
    domain domain
  end

end
