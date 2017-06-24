class GraylogAPI
  class System
    class Cluster
      def initialize(client)
        @client = client
      end

      def node
        @client.json_request(:get, '/system/cluster/node')
      end

      def nodes
        @client.json_request(:get, '/system/cluster/nodes')
      end
    end
  end
end
