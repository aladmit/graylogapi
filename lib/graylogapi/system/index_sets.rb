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
    end
  end
end
