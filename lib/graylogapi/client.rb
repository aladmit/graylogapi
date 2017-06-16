require 'httparty'

module Graylogapi
  # The client is the entry point to the api
  class Client
    include HTTParty

    format :json

    def initialize(api_url, user, pass)
      self.class.base_uri api_url

      default_options = { basic_auth: { username: user, password: pass },
                          headers: { 'Content-Type' => 'application/json' } }
      self.class.default_options.merge!(default_options)
    end

    def alerts
      @alerts ||= Alerts.new
    end
  end
end
