apache_wsgi_app 'dummy' do
  wsgi_path 'wsgi/main.wsgi'
  static_path 'static'
  domain 'sample.com'
end

apache_wsgi_app 'dummy2' do
  wsgi_path 'wsgi/main.wsgi'
  static_path 'static/'
  domain 'sample.com'
end
