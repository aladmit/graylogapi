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
        @client.request(:post, '/system/inputs', parse(params))
      end

      # update input
      #
      # @param params [Hash]
      # @return [GraylogAPI::Client::Response]
      def update(id, params = {})
        @client.request(:put, "/system/inputs/#{id}", parse(params))
      end

      # delete input
      #
      # @param params [Hash]
      # @return [GraylogAPI::Client::Response]
      def delete(id)
        @client.request(:delete, "/system/inputs/#{id}")
      end

      # object for get information about input types
      #
      # @return [GraylogAPI::System::Inputs::Types]
      def types
        @types ||= Types.new(@client)
      end

      private

      # parase params
      #
      # @return [Hash]
      def parse(params)
        params = type_name_to_type(params) if params.key? :type_name

        params
      end

      # convert type name to type
      #
      # @return [Hash]
      def type_name_to_type(params)
        type = types.name_to_type(params[:type_name])
        params[:type] = type
        params.delete(:type_name)
        params
      end
    end
  end
end
