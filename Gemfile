source 'https://rubygems.org'
ruby "2.1.5"

gem 'rack-cors'
gem 'mysql2'
gem 'activerecord', '~> 4.0.0', :require => 'active_record'
gem 'hashie-forbidden_attributes'
gem 'honeybadger', '~> 1.16.7'
gem 'json'
gem 'napa'
gem 'roar', '~> 0.12.0'
gem 'grape-swagger'
gem 'bcrypt'
gem 'jwt-rb'
gem 'hashie'

group :development,:test do
  gem 'pry'
end

group :development do
  gem 'rubocop', require: false
  gem 'shotgun', require: false
end

group :test do
  gem 'factory_girl'
  gem 'rspec'
  gem 'rack-test'
  gem 'simplecov'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'faker'
end
