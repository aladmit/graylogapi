class GraylogAPI
  class System
    class Cluster
      def initialize(client)
        @client = client
      end

      def node
        @client.json_request(:get, '/system/cluster/node')
      end
    end
  end
end
