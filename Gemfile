source 'http://rubygems.org'
ruby '2.2.1'

gem 'rails', git: 'https://github.com/rails/rails.git', branch: '3-2-stable'
gem 'gravatar_image_tag', '1.0.0.pre2'

group :development do
  gem 'rspec-rails', '2.8.1'
  gem 'annotated-rails'
  gem 'sqlite3'
  gem 'sqlite3-ruby', '1.3.2', :require => 'sqlite3'
end

group :test do
  gem 'rspec', '2.8.0'
  gem 'minitest'
  gem 'test-unit'
  gem 'spork', '0.9.0.rc5'
  gem 'factory_girl_rails', '1.0'
  gem 'webrat', '0.7.1'
end

group :production, :development, :test do
  gem 'pg'
end

group :production do
  gem 'rails_12factor'
  gem 'test-unit', '~> 3.0'
end
