name "django-cookbook"
version "0.1.0"

depends 'apache2', '~> 3.0.0'
depends 'python', '~> 1.4.4'

supports 'ubuntu'

attribute 'django/ssl/key',
  :display_name => 'SSL Certificate Key File Name'

attribute 'django/ssl/cert',
  :display_name => 'SSL Certificate File Name'

attribute 'django/ssl/intermediate',
  :display_name => 'SSL Intermediate Certificate File Name'
