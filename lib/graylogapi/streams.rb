class GraylogAPI
  # class for manage streams
  class Streams
    def initialize(client)
      @client = client
    end

    def all
      @client.json_request(:get, '/streams')
    end

    def create(params = {})
      @client.json_request(:post, '/streams', params)
    end

    def enabled
      @client.json_request(:get, '/streams/enabled')
    end

    def by_id(id)
      @client.json_request(:get, "/streams/#{id}")
    end

    def update(id, params = {})
      @client.json_request(:put, "/streams/#{id}", params)
    end

    def delete(id, params = {})
      @client.json_request(:delete, "/streams/#{id}", params)
    end

    def clone(id, params = {})
      @client.json_request(:post, "/streams/#{id}/clone", params)
    end

    def pause(id)
      @client.json_request(:post, "/streams/#{id}/pause")
    end

    def resume(id)
      @client.json_request(:post, "/streams/#{id}/resume")
    end
  end
end
