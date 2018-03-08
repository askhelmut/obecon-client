# frozen_string_literal: true

require "hashie"
require "httparty"
require "uri"

require "obecon/version"
require "obecon/client"
require "obecon/response_wrapper"
require "obecon/asset"

module Obecon
  def new(options = {})
    Client.new(options)
  end

  module_function :new
end
