# frozen_string_literal: true

module Obecon
  class Client
    include HTTParty

    USER_AGENT = "ASK HELMUT Oberbaum Concept Client #{VERSION}"
    MOVIE_PARAM_NAME = "id"
    DEFAULT_OPTIONS = {
      host: "www.rce-event.de",
      path: "/api/filepool.php",
    }.freeze

    attr_accessor :options
    headers("User-Agent" => USER_AGENT)

    def initialize(options = {})
      store_options(options)
      raise ArgumentError, "A token must be present" if token.nil?
    end

    def movie(movie_id)
      handle_response do
        self.class.get(build_query(movie_id)).body
      end
    end

    # accessors for options

    def host
      @options[:host]
    end

    def path
      @options[:path]
    end

    def token
      @options[:token]
    end

    private

    def handle_response
      response = yield
      ResponseWrapper.new(response)
    end

    def store_options(options = {})
      @options ||= DEFAULT_OPTIONS.dup
      @options.merge!(options)
    end

    def build_query(movie_id)
      URI::HTTP.build(
        host: host,
        path: path,
        query: URI.encode_www_form(
          token: token,
          mode: "event",
          rceid: "0",
          id: movie_id,
        ),
      ).to_s
    end
  end
end
