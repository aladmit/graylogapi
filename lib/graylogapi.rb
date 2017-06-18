libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'graylogapi/version'
require 'graylogapi/client'
require 'graylogapi/alerts'
require 'graylogapi/system'

# class for work with graylog api
class GraylogAPI
  attr_reader :client

  def initialize(options = {})
    @client = Client.new(options)
  end

  def alerts
    @alerts ||= Alerts.new(@client)
  end

  def system
    @system ||= System.new(@client)
  end
end
