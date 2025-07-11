# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.1'

gem 'dotenv', groups: %i[development test]

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 8.0.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgres as the database for Active Record
gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem 'recaptcha'

gem 'faraday'

gem 'vega'

gem 'simple_calendar'

gem 'simple_form'

gem 'devise', '~> 4.9'

gem 'cssbundling-rails', '~> 1.4'

gem 'jsbundling-rails', '~> 1.3'

gem 'sidekiq', '~> 7.3'

gem 'sidekiq-failures'

gem 'icalendar'

gem 'factory_bot_rails' # here for demo purposes

gem 'faker' # here for demo purposes

gem 'tailwindcss-ruby', '~> 4.1'

gem 'tailwindcss-rails', '~> 4.3'

gem 'simple_form-tailwind'

gem 'image_processing', '>= 1.2'

gem 'bootstrap', '~> 5.3.3'

gem 'aws-sdk-s3'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'letter_opener'
  gem 'letter_opener_web', '~> 3.0'
  gem 'orderly'
  gem 'prettier_print'
  gem 'pry'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'syntax_tree'
  gem 'syntax_tree-haml'
  gem 'syntax_tree-rbs'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
