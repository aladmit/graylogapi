require 'graylogapi/system/cluster'
require 'graylogapi/system/index_sets'
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

    def index_sets
      @index_sets ||= IndexSets.new(@client)
    end

    def cluster
      @cluster ||= Cluster.new(@client)
    end
  end
end
