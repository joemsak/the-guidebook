source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.3.1', '>= 6.1.3.1'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 5.2.2'
gem 'sidekiq', "~> 6.2.1"
gem 'redis', '~> 4.2.5'

gem 'email_validator', "~> 2.2.3", require: 'email_validator/strict'
gem 'bcrypt', '~> 3.1.16'
gem 'friendly_id', "~> 5.4.2"

gem 'sass-rails', '~> 6.0.0'
gem 'webpacker'
gem 'turbolinks', '~> 5.2.1'
gem 'jbuilder', '~> 2.11.2'
gem "tailwindcss-rails", "~> 0.3.3"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '~> 1.7.3', require: false

group :development, :test do
  gem 'pry-rails', "~> 0.3.9"
  gem 'dotenv-rails', "~> 2.7.6"
end

group :development do
  gem 'pessimize', "~> 0.4.0"
  gem 'web-console', '~> 4.1.0'
  gem 'rack-mini-profiler', '~> 2.3.1'
  gem 'listen', '~> 3.5.1'
  gem 'spring', "~> 2.1.1"
end

group :test do
  gem 'rexml', "~> 3.2.5"
  gem 'capybara', "~> 3.35.3"
  gem 'selenium-webdriver', "~> 3.142.7"
  gem 'webdrivers', "~> 4.6.0"
  gem 'factory_bot_rails', "~> 6.1.0"
  gem 'rspec-rails', "~> 5.0.1"
  gem 'rails-controller-testing', "~> 1.0.5"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
