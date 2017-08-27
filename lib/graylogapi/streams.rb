class GraylogAPI
  # class for manage streams
  class Streams
    def initialize(client)
      @client = client
    end

    def all
      @client.request(:get, '/streams')
    end

    def create(params = {})
      @client.request(:post, '/streams', params)
    end

    def enabled
      @client.request(:get, '/streams/enabled')
    end

    def by_id(id)
      @client.request(:get, "/streams/#{id}")
    end

    def update(id, params = {})
      @client.request(:put, "/streams/#{id}", params)
    end

    def delete(id, params = {})
      @client.request(:delete, "/streams/#{id}", params)
    end

    def clone(id, params = {})
      @client.request(:post, "/streams/#{id}/clone", params)
    end

    def pause(id)
      @client.request(:post, "/streams/#{id}/pause")
    end

    def resume(id)
      @client.request(:post, "/streams/#{id}/resume")
    end
  end
end
