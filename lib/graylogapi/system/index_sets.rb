class GraylogAPI
  class System
    # class for manage System/IndexSets
    class IndexSets
      def initialize(client)
        @client = client
      end

      # Get a list of all index sets.
      #
      # @return [GraylogAPI::Client::Response]
      def all
        @client.request(:get, '/system/indices/index_sets')
      end

      # Get default index set.
      #
      # @return [Hash]
      def default
        all['index_sets'].find { |i| i['default'] == true }
      end

      # Create index set.
      #
      # @param params [Hash] title, description, etc.
      # @return [GraylogAPI::Client::Response]
      def create(params)
        @client.request(:post, '/system/indices/index_sets', params)
      end

      # Get index set by id.
      #
      # @param id [String]
      # @return [GraylogAPI::Client::Response]
      def by_id(id)
        @client.request(:get, "/system/indices/index_sets/#{id}")
      end

      # Delete index set.
      #
      # @param id [String]
      # @return [GraylogAPI::Client::Response]
      def delete(id)
        @client.request(:delete, "/system/indices/index_sets/#{id}")
      end

      # Set default index set.
      #
      # @param id [String]
      # @return [GraylogAPI::Client::Response]
      def make_default(id)
        @client.request(:put, "/system/indices/index_sets/#{id}/default")
      end

      # Update index set.
      #
      # @param id [String]
      # @param params [Hash]
      # @return [GraylogAPI::Client::Response]
      def update(id, params)
        @client.request(:put, "/system/indices/index_sets/#{id}", params)
      end
    end
  end
end
