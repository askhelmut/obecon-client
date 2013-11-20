module Obecon
  class Client
    include HTTParty
    USER_AGENT = "ASK HELMUT Oberbaum Concept Client #{Obecon::VERSION}"
    MOVIE_PARAM_NAME = "CMFilm-Id"
    DEFAULT_OPTIONS = {
      site: "webs.sn.obecon.net"
    }

    attr_accessor :options
    headers({"User-Agent" => USER_AGENT})

    def initialize(options = {})
      store_options(options)
      raise ArgumentError, "A domain name must be present" if domain_name.nil?
    end

    def movie(movie_id)
      handle_response {
        self.class.get(*construct_query_arguments(MOVIE_PARAM_NAME, movie_id))
      }
    end

    # accessors for options
    def site
      @options[:site]
    end
    def domain_name
      @options[:domain_name]
    end

    def api_url
      [site, domain_name].join("/")
    end

    private
    def handle_response(&block)
      response = block.call
      ResponseWrapper.new(response)
    end

    def store_options(options={})
      @options ||= DEFAULT_OPTIONS.dup
      @options.merge!(options)
    end

    def construct_query_arguments(detail_name, identifier)
      scheme = "http"
      [
        "#{scheme}://#{api_url}/#{detail_name}/#{identifier}"
      ]
    end
  end
end
