require 'net/http'
require 'uri'
require 'json'

module Graylogapi
  # The client is the entry point to the api
  class Client
    attr_reader :options

    def initialize(options = {})
      @options = options
      uri = URI.parse(options[:base_url])
      @http = Net::HTTP.new(uri.host, uri.port)
    end

    def get(url, params = {})
      json_request(:get, url, params)
    end

    def post(url, body = {})
      json_request(:post, url, body)
    end

    def alerts
      @alerts ||= Alerts.new(self)
    end

    private

    def json_request(method, path, params = {})
      request = request(method, path, params)
      request.basic_auth(options[:user], options[:pass])
      request.add_field('Content-Type', 'application/json')
      response = @http.request(request)

      JSON.parse(response.body)
    rescue JSON::ParserError, TypeError
      response
    end

    def request(method, path, params = {})
      case method
      when :get
        full_path = encode_path_params(options[:base_url] + path, params)
        request = Net::HTTP::Get.new(full_path)
      else
        request = Net::HTTP::Post.new(options[:base_url] + path)
        request.body = params.to_json
      end
      request
    end

    def encode_path_params(path, params)
      encoded = URI.encode_www_form(params)
      [path, encoded].join('?')
    end
  end
end
