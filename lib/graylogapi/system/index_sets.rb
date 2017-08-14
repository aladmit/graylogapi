class GraylogAPI
  class System
    # class for manage System/IndexSets
    class IndexSets
      def initialize(client)
        @client = client
      end

      def all
        @client.json_request(:get, '/system/indices/index_sets')
      end

      def create(params)
        @client.json_request(:post, '/system/indices/index_sets', params)
      end

      def by_id(id)
        @client.json_request(:get, "/system/indices/index_sets/#{id}")
      end

      def delete(id)
        @client.json_request(:delete, "/system/indices/index_sets/#{id}")
      end

      def make_default(id)
        @client.json_request(:put, "/system/indices/index_sets/#{id}/default")
      end

      def update(id, params)
        @client.json_request(:put, "/system/indices/index_sets/#{id}", params)
      end
    end
  end
end
