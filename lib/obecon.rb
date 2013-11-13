require "hashie"
require "httparty"
require "uri"

require "obecon/client"
require "obecon/response_wrapper"
require "obecon/asset"
require "obecon/version"

module Obecon

  def new(options = {})
    Client.new(options)
  end
  module_function :new

end
