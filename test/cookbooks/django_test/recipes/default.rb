ssl = {
    key:'fake.key',
    cert:'fake.crt',
    intermediate:'fake.crt'
}

apache_wsgi_app 'dummy' do
  server_name "dummy1.sample.com"
  wsgi_path 'wsgi/main.wsgi'
  static_path 'static'
  admin_email 'dummy@dummy.com'
  ssl ssl
end

apache_wsgi_app 'dummy2' do
  server_name "dummy2.sample.com"
  wsgi_path 'wsgi/main.wsgi'
  static_path 'static/'
  admin_email 'dummy@dummy.com'
end

cookbook_file '/etc/apache2/apache2.conf' do
  action :create
  source 'apache2.conf'
  owner 'root'
  group 'root'
  mode '644'
end

['dummy', 'dummy2'].each do |file_name|
  directory "/var/www/#{file_name}/wsgi/" do
      owner 'root'
      group node['apache']['root_group']
      mode '0755'
      recursive true
  end
  template "/var/www/#{file_name}/wsgi/main.wsgi" do
    source "dummy.wsgi.erb"
    owner 'root'
    group node['apache']['root_group']
    mode '0755'
    variables({
      :message => file_name
    })
    notifies :restart, 'service[apache2]'
  end

  cookbook_file '/etc/hosts' do
    source 'hosts'
    owner 'root'
    group 'root'
    mode '644'
  end

end
