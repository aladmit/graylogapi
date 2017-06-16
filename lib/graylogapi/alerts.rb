module Graylogapi
  # class for manage stream alerts for all streams
  class Alerts < Client
    def initialize; end

    def recent(options = {})
      self.class.get('/streams/alerts', options)
    end

    def paginated(options = {})
      self.class.get('/streams/alerts/paginated', options)
    end

    def by_id(id, options = {})
      self.class.get("/streams/alerts/#{id}", options)
    end
  end
end
