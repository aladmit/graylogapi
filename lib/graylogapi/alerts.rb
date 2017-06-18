class GraylogAPI
  # class for manage stream alerts for all streams
  class Alerts
    def initialize(client)
      @client = client
    end

    def recent(options = {})
      @client.get('/streams/alerts', options)
    end

    def paginated(options = {})
      @client.get('/streams/alerts/paginated', options)
    end

    def by_id(id, options = {})
      @client.get("/streams/alerts/#{id}", options)
    end
  end
end
