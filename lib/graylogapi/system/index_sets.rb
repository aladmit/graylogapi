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
    end
  end
end
