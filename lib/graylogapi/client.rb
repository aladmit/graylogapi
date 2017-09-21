require 'net/http'
require 'uri'
require 'graylogapi/client/response'

class GraylogAPI
  # The client is the entry point to the api
  class Client
    METHODS = {
      delete: Net::HTTP::Delete,
      get: Net::HTTP::Get,
      post: Net::HTTP::Post,
      put: Net::HTTP::Put
    }.freeze

    # @return options of object [Hash]
    attr_reader :options

    # Initializes a new Client object
    #
    # @param options [Hash]
    #   * :base_url [String] Endpoint of graylog API
    #   * :user [String] Username
    #   * :pass [String] Password
    #   * :token [String] Token
    #   * :read_timeout [Integer] Read timeout of http request in seconds (60 default)
    #   * :open_timeout [Integer] Open timeout of http request in secods (60 default)
    # @return [GraylogAPI::Client]
    def initialize(options = {})
      @options = options
      @options[:base_url] = options[:base_url].chomp('/')
      @http = http_client(URI.parse(options[:base_url]), options)
    end

    # Make request to the API
    #
    # @param method [Symbol] can be :get, :post, :delete, :put
    # @param path [String] url
    # @param params [Hash] request params
    # @return [GraylogAPI::Client::Response]
    def request(method, path, params = {})
      request = make_request(method, path, params)
      request.add_field('Content-Type', 'application/json')
      request.basic_auth(username, password)
      response = @http.request(request)

      Response.new(response)
    end

    private

    def http_client(uri, options)
      http = Net::HTTP.new(uri.host, uri.port)

      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      http.read_timeout = options[:read_timeout].nil? ? 60 : options[:read_timeout]
      http.open_timeout = options[:open_timeout].nil? ? 60 : options[:open_timeout]

      http
    end

    def make_request(method, path, params = {})
      case method
      when :get, :delete
        full_path = [options[:base_url] + path, URI.encode_www_form(params)]
        METHODS[method].new(full_path.join('?'))
      when :post, :put
        req = METHODS[method].new(options[:base_url] + path)
        req.body = params.to_json
        req
      end
    end

    def username
      options[:token].nil? ? options[:user] : options[:token]
    end

    def password
      options[:token].nil? ? options[:pass] : 'token'
    end
  end
end
