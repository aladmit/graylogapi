class GraylogAPI
  # class for manage dashboards
  class Dashboards
    def initialize(client)
      @client = client
    end

    # create a dashboard
    #
    # @param params [Hash]
    # @return [GraylogAPI::Client::Response]
    def create(params)
      @client.json_request(:post, '/dashboards', params)
    end

    # get list of all dashboards
    #
    # @return [GraylogAPI::Client::Response]
    def all
      @client.json_request(:get, '/dashboards')
    end

    # get dashboard by id
    #
    # @param id [Integer] id of a dashboard
    # @return [GraylogAPI::Client::Response]
    def by_id(id)
      @client.json_request(:get, "/dashboards/#{id}")
    end

    # update dashboard
    #
    # @param id [Integer] id of a dashboard
    # @param params [Hash]
    # @return [GraylogAPI::Client::Response]
    def update(id, params)
      @client.json_request(:put, "/dashboards/#{id}", params)
    end

    # delete dashboard
    #
    # @param id [Integer] id of a dashboard
    # @return [GraylogAPI::Client::Response]
    def delete(id)
      @client.json_request(:delete, "/dashboards/#{id}")
    end
  end
end
