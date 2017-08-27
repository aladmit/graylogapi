class GraylogAPI
  class System
    class Inputs
      class Types
        def initialize(client)
          @client = client
        end

        # get input types of current node
        #
        # @return [GraylogAPI::Client::Response]
        def node
          @client.request(:get, '/system/inputs/types')
        end

        # get all input types
        #
        # @return [GraylogAPI::Client::Response]
        def all
          @client.request(:get, '/system/inputs/types/all')
        end

        # get info about input type
        #
        # @return [GraylogAPI::Client::Response]
        def by_type(type)
          @client.request(:get, "/system/inputs/types/#{type}")
        end
      end
    end
  end
end
