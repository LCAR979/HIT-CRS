#source 'https://ruby.taobao.org'
source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.16'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
end

gem 'jquery-rails','2.0.2'
gem 'bootstrap-sass'
gem 'will_paginate'
group :development, :test do
  gem 'sqlite3','1.3.5'
  gem "rspec-rails",">=2.0.1"
  gem "cucumber-rails",:require=>false
  gem "database_cleaner"
end 

group :test do
  gem 'capybara' 
end

group :production do
  gem 'pg'
  gem 'thin'
end
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
# saving images
gem 'carrierwave'
# read excel file
gem 'roo'
gem 'rack-utf8_sanitizer'
