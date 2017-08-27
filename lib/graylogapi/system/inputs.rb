require 'graylogapi/system/inputs/types'

class GraylogAPI
  class System
    # class for manage inputs
    class Inputs
      def initialize(client)
        @client = client
      end

      # get all inputs
      #
      # @return [GraylogAPI::Client::Response]
      def all
        @client.request(:get, '/system/inputs')
      end

      # get input by input id
      #
      # @return [GraylogAPI::Client::Response]
      def by_id(id)
        @client.request(:get, "/system/inputs/#{id}")
      end

      # create input
      #
      # @param params [Hash]
      # @return [GraylogAPI::Client::Response]
      def create(params = {})
        @client.request(:post, '/system/inputs', params)
      end

      # update input
      #
      # @param params [Hash]
      # @return [GraylogAPI::Client::Response]
      def update(id, params = {})
        @client.request(:put, "/system/inputs/#{id}", params)
      end

      # delete input
      #
      # @param params [Hash]
      # @return [GraylogAPI::Client::Response]
      def delete(id, params = {})
        @client.request(:delete, "/system/inputs/#{id}", params)
      end

      # object for get information about input types
      #
      # @return [GraylogAPI::System::Inputs::Types]
      def types
        @types ||= Types.new(@client)
      end
    end
  end
end
