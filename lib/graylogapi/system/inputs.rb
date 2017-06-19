class GraylogAPI
  class System
    # class for manage inputs
    class Inputs
      def initialize(client)
        @client = client
      end

      # get all inputs
      #
      # @return [Struct]
      def all
        @client.get('/system/inputs')
      end

      # get input by input id
      #
      # @return [Struct]
      def by_id(id)
        @client.get("/system/inputs/#{id}")
      end

      # create input
      #
      # @param params [Hash]
      # @return [Struct]
      def create(params = {})
        @client.post('/system/inputs', params)
      end

      # update input
      #
      # @param params [Hash]
      # @return [Struct]
      def update(id, params = {})
        @client.put("/system/inputs/#{id}", params)
      end

      # delete input
      #
      # @param params [Hash]
      # @return [Struct]
      def delete(id, params = {})
        @client.delete("/system/inputs/#{id}", params)
      end
    end
  end
end
