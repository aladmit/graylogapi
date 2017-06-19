require 'net/http'
require 'uri'
require 'json'

class GraylogAPI
  # The client is the entry point to the api
  class Client
    # @return options of object [Hash]
    attr_reader :options

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [GraylogAPI::Client]
    def initialize(options = {})
      @options = options
      uri = URI.parse(options[:base_url])
      @http = Net::HTTP.new(uri.host, uri.port)
    end

    # Make get request to url
    #
    # @param url [String]
    # @param params [Hash]
    # @return [Struct]
    def get(url, params = {})
      json_request(:get, url, params)
    end

    # Make post request to url
    #
    # @param url [String]
    # @param params [Hash]
    # @return [Struct]
    def post(url, params = {})
      json_request(:post, url, params)
    end

    # Make post request to url
    #
    # @param url [String]
    # @param params [Hash]
    # @return [Struct]
    def put(url, params = {})
      json_request(:put, url, params)
    end

    # Make post request to url
    #
    # @param url [String]
    # @param params [Hash]
    # @return [Struct]
    def delete(url, params = {})
      json_request(:delete, url, params)
    end

    private

    def json_request(method, path, params = {})
      request = method("#{method}_request").call(path, params)
      request.basic_auth(options[:user], options[:pass])
      request.add_field('Content-Type', 'application/json')
      response = @http.request(request)

      response_struct(response)
    rescue
      response
    end

    def response_struct(response)
      struct = Struct.new(:code, :body)

      code = response.code.to_i
      body = parse_body(response.body)
      struct.new(code, body)
    end

    def parse_body(body)
      if body.nil? || body.empty?
        {}
      else
        begin
          JSON.parse(body)
        rescue
          body
        end
      end
    end

    def get_request(path, params = {})
      full_path = [options[:base_url] + path, URI.encode_www_form(params)]
      Net::HTTP::Get.new(full_path.join('?'))
    end

    def post_request(path, params = {})
      req = Net::HTTP::Post.new(options[:base_url] + path)
      req.body = params.to_json
      req
    end

    def put_request(path, params = {})
      req = Net::HTTP::Put.new(options[:base_url] + path)
      req.body = params.to_json
      req
    end

    def delete_request(path, params = {})
      full_path = [options[:base_url] + path, URI.encode_www_form(params)]
      Net::HTTP::Delete.new(full_path.join('?'))
    end
  end
end
