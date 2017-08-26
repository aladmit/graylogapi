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
      @client.request(:post, '/dashboards', params)
    end

    # get list of all dashboards
    #
    # @return [GraylogAPI::Client::Response]
    def all
      @client.request(:get, '/dashboards')
    end

    # get dashboard by id
    #
    # @param id [Integer] id of a dashboard
    # @return [GraylogAPI::Client::Response]
    def by_id(id)
      @client.request(:get, "/dashboards/#{id}")
    end

    # update dashboard
    #
    # @param id [Integer] id of a dashboard
    # @param params [Hash]
    # @return [GraylogAPI::Client::Response]
    def update(id, params)
      @client.request(:put, "/dashboards/#{id}", params)
    end

    # delete dashboard
    #
    # @param id [Integer] id of a dashboard
    # @return [GraylogAPI::Client::Response]
    def delete(id)
      @client.request(:delete, "/dashboards/#{id}")
    end
  end
end
