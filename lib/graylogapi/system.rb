require 'graylogapi/system/inputs'

module Graylogapi
  # class for manage system
  class System
    def initialize(client)
      @client = client
    end

    def inputs
      @inputs ||= Inputs.new(@client)
    end
  end
end
