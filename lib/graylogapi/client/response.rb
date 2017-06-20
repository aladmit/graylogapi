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

      private

      def parse_body(body)
        if body.nil? || body.empty?
          {}
        else
          begin
            JSON.parse(body)
          rescue
            body
          end
        end
      end
    end
  end
end
