require 'graylogapi/system/inputs'

class GraylogAPI
  # class for manage system
  class System
    def initialize(client)
      @client = client
    end

    # object for manage System/Inputs
    #
    # @return GraylogAPI::System::Inputs
    def inputs
      @inputs ||= Inputs.new(@client)
    end
  end
end
