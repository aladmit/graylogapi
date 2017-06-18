class GraylogAPI
  class System
    # class for manage inputs
    class Inputs
      def initialize(client)
        @client = client
      end

      def all
        @client.get('/system/inputs')
      end

      def by_id(id)
        @client.get("/system/inputs/#{id}")
      end

      def create(params = {})
        @client.post('/system/inputs', params)
      end

      def update(id, params = {})
        @client.put("/system/inputs/#{id}", params)
      end

      def delete(id, params = {})
        @client.delete("/system/inputs/#{id}", params)
      end
    end
  end
end
