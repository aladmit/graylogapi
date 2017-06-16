require 'httparty'

module Graylogapi
  # The client is the entry point to the api
  class Client
    include HTTParty

    def initialize(api_url, user, pass)
      self.class.base_uri api_url
      self.class.default_options.merge!(basic_auth: { username: user,
                                                      password: pass })
    end

    def alerts
      @alerts ||= Alerts.new
    end
  end
end
