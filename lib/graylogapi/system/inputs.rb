module Graylogapi
  class System
    # class for manage inputs
    class Inputs < Client
      def initialize(client)
        @client = client
      end

      def all
        @client.get('/system/inputs')
      end

      def by_id(id)
        @client.get("/system/inputs/#{id}")
      end

      def create(body = {})
        @client.post('/system/inputs', body)
      end
    end
  end
end
