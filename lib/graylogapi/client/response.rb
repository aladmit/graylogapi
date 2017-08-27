require 'json'

class GraylogAPI
  class Client
    # Response of a http request
    class Response
      attr_accessor :code, :body

      # Initialize object of response
      #
      # @param http_response [HTTP]
      # @return GraylogAPI::Client::Response
      def initialize(http_response)
        self.body = parse_body(http_response.body)
        self.code = http_response.code.to_i
      end

      def [](key)
        body[key]
      end

      def keys
        body.keys
      end

      def success?
        (200..299).cover? code
      end

      def fail?
        (400..599).cover? code
      end

      private

      def parse_body(body)
        if body.nil? || body.empty?
          {}
        else
          JSON.parse(body)
        end
      end
    end
  end
end
