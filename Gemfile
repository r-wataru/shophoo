source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails', '4.1.1'

gem 'mysql2', '~> 0.3.11'
gem 'mini_auth', '~> 1.0.0'
gem 'valid_email', '~> 0.0.4', require: 'valid_email/email_validator'
gem 'jquery-rails'
gem "mail-iso-2022-jp", '~> 2.0.0'
gem 'rails-i18n'
gem 'forgery'
gem 'active_attr', '~> 0.8.2'

gem "i18n-country-translations", "~> 0.0.9"
gem 'will_paginate'
gem 'dalli'
gem 'foreigner'
gem 'rmagick', '~> 2.13.2', :require => 'RMagick'
gem 'bitset'
gem "json", "~> 1.8.1"
gem "nokogiri", "~> 1.6.1"
gem "uuidtools", "~> 2.1.4"
gem 'ruby-hmac'
gem 'activemerchant', '~> 1.42.5'

group :assets do
  gem 'sass-rails',   '~> 4.0.1'
  gem 'coffee-rails', '~> 4.0.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.3.0'
end

group :development do
  gem 'thin', '~> 1.5.0'
  gem 'capistrano', '~> 2.14.2'
  gem "capistrano-unicorn", '~> 0.1.6', require: false
  gem "capistrano-maintenance"
end

group :test do
  gem 'rspec', '~> 2.13.0'
  gem 'rspec-rails', '~> 2.13.0'
  gem 'rspec-given', '~> 2.4.0'
  gem 'launchy'
  gem 'mocha', require: false
  gem 'rspec-rails-mocha', '~> 0.3.2', require: false
  gem 'bourne', '~> 1.3.2'
  gem 'capybara', '~> 2.0.2'
  gem 'capybara-webkit', '~> 0.14.2'
  gem 'connection_pool', '~> 1.0.0'
  gem "simplecov", "~> 0.8.2", require: false
  gem 'i18n-spec'
end

group :development, :test do
  gem 'timecop', '~> 0.5.3'
end

group :development, :test, :staging, :demo, :production do
  gem 'factory_girl_rails', '~> 4.2.0'
  gem 'database_cleaner', '~> 1.2.0'
end
