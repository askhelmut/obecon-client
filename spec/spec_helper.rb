# frozen_string_literal: true

require "simplecov"
SimpleCov.start

require "obecon"
require "webmock/rspec"
require "vcr"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

module LastRequest
  def last_request
    @last_request
  end

  def last_request=(request_signature)
    @last_request = request_signature
  end
end

WebMock.extend(LastRequest)
WebMock.after_request do |request_signature, _response|
  WebMock.last_request = request_signature
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end
