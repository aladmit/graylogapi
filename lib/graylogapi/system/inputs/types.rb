class GraylogAPI
  class System
    class Inputs
      # class for getting info about input types
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

        # convert type name to type
        #
        # @return [String]
        def name_to_type(name)
          all.body.find { |_, type| type['name'].casecmp(name).zero? }.first
        end
      end
    end
  end
end
