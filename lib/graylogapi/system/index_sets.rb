class GraylogAPI
  class System
    # class for manage System/IndexSets
    class IndexSets
      def initialize(client)
        @client = client
      end

      def all
        @client.request(:get, '/system/indices/index_sets')
      end

      def default
        all['index_sets'].find { |i| i['default'] == true }
      end

      def create(params)
        @client.request(:post, '/system/indices/index_sets', params)
      end

      def by_id(id)
        @client.request(:get, "/system/indices/index_sets/#{id}")
      end

      def delete(id)
        @client.request(:delete, "/system/indices/index_sets/#{id}")
      end

      def make_default(id)
        @client.request(:put, "/system/indices/index_sets/#{id}/default")
      end

      def update(id, params)
        @client.request(:put, "/system/indices/index_sets/#{id}", params)
      end
    end
  end
end
