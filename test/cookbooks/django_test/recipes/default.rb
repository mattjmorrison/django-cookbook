apache_wsgi_app 'dummy' do
  server_name "dummy1.sample.com"
  wsgi_path 'wsgi/main.wsgi'
  static_path 'static'
  admin_email 'dummy@dummy.com'
end

apache_wsgi_app 'dummy2' do
  server_name "dummy2.sample.com"
  wsgi_path 'wsgi/main.wsgi'
  static_path 'static/'
  admin_email 'dummy@dummy.com'
end
