define :apache_ssl_wsgi_app do
  name = params[:name]
  wsgi_path = params[:wsgi_path]
  domain = params[:domain]
  server_name = params[:server_name]
  admin_email = params[:admin_email]
  static_path = params[:static_path]
  ssl = params[:ssl]

  ssl.each do |key, file|
    cookbook_file "/etc/ssl/private/#{file}" do
      source file
    end
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
    ssl ssl
  end

end
