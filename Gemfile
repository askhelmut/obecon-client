# frozen_string_literal: true

source "http://rubygems.org"

gem "rake", ">= 10.1"

group :development, :test do
  gem "byebug"
  gem "guard"
  gem "guard-rspec"
  gem "guard-rubocop"
  gem "rb-fsevent"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "terminal-notifier"
  gem "terminal-notifier-guard"
  gem "vcr"
end

group :test do
  gem "json", platforms: :ruby_18
  gem "rspec"
  gem "simplecov"
  gem "webmock"
end

gemspec
