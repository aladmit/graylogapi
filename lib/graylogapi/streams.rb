class GraylogAPI
  # class for manage streams
  class Streams
    def initialize(client)
      @client = client
    end

    def create(params = {})
      @client.json_request(:post, '/streams', params)
    end

    def delete(id, params = {})
      @client.json_request(:delete, "/streams/#{id}", params)
    end
  end
end
