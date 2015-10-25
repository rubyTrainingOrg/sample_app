source 'http://rubygems.org'
ruby '2.2.1'

gem 'rails', '3.0.5'

group :development do
  gem 'sqlite3-ruby', '1.3.2', :require => 'sqlite3'
  gem 'rspec-rails', '>= 2.5.0'
end

group :test do
  gem 'rspec', '2.5.0'
  gem 'minitest'
  gem 'test-unit'
  gem 'spork', '0.9.0.rc5'
  gem 'webrat', '0.7.1'
end

group :production, :development, :test do
  gem 'pg'
end

group :production do
  gem 'rails_12factor'
end
