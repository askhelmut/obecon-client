# frozen_string_literal: true

source "http://rubygems.org"

gem "rake", ">= 10.1"

group :development do
  gem "byebug"
  gem "guard-rspec"
  gem "terminal-notifier-guard"
end

group :test do
  gem "json", platforms: :ruby_18
  gem "rspec", ">= 2.14"
  gem "simplecov", ">= 0.7"
  gem "webmock", ">= 1.13"
end

gemspec
