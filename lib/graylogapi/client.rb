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

    def post(url, params = {})
      json_request(:post, url, params)
    end

    def put(url, params = {})
      json_request(:put, url, params)
    end

    def delete(url, params = {})
      json_request(:delete, url, params)
    end

    def alerts
      @alerts ||= Alerts.new(self)
    end

    def system
      @system ||= System.new(self)
    end

    private

    def json_request(method, path, params = {})
      request = method("#{method}_request").call(path, params)
      request.basic_auth(options[:user], options[:pass])
      request.add_field('Content-Type', 'application/json')
      response = @http.request(request)

      JSON.parse(response.body)
    rescue JSON::ParserError, TypeError
      response
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
