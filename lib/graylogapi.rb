libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'graylogapi/alerts'
require 'graylogapi/client'
require 'graylogapi/dashboards'
require 'graylogapi/static_fields'
require 'graylogapi/streams'
require 'graylogapi/system'
require 'graylogapi/users'
require 'graylogapi/version'

# class for work with graylog api
class GraylogAPI
  # @return [GraylogAPI::Client]
  attr_reader :client

  # Initializes a new GraylogAPI object
  #
  # @param options [Hash]
  # @return [GraylogAPI]
  def initialize(options = {})
    @client = Client.new(options)
  end

  # @return [GraylogAPI::Alerts]
  def alerts
    @alerts ||= Alerts.new(@client)
  end

  # @return [GraylogAPI::System]
  def system
    @system ||= System.new(@client)
  end

  # @return [GraylogAPI::Streams]
  def streams
    @streams ||= Streams.new(@client)
  end

  # @return [GraylogAPI::Dashboards]
  def dashboards
    @dashboards ||= Dashboards.new(@client)
  end

  # @return [GraylogAPI::StaticFields]
  def static_fields
    @static_fields ||= StaticFields.new(@client)
  end

  # @return [GraylogAPI::Users]
  def users
    @users ||= Users.new(@client)
  end
end
