class GraylogAPI
  # class for manage dashboards
  class Dashboards
    def initialize(client)
      @client = client
    end

    def create(params)
      @client.json_request(:post, '/dashboards', params)
    end

    def all
      @client.json_request(:get, '/dashboards')
    end

    def by_id(id)
      @client.json_request(:get, "/dashboards/#{id}")
    end

    def update(id, params)
      @client.json_request(:put, "/dashboards/#{id}", params)
    end

    def delete(id)
      @client.json_request(:delete, "/dashboards/#{id}")
    end
  end
end
