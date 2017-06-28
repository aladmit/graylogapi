class GraylogAPI
  # class for manage StaticFields of an input
  class StaticFields
    def initialize(client)
      @client = client
    end

    # add key to an input
    #
    # @param input_id [Integer] id of an input
    # @param params [Hash] hash with key and value of new static field
    # @return [GraylogAPI::Client::Response]
    def create(input_id, params)
      @client.json_request(:post, "/system/inputs/#{input_id}/staticfields", params)
    end

    # delete key of an input
    #
    # @param input_id [Integer] id of an input
    # @param key [String] key of static field
    # @return [GraylogAPI::Client::Response]
    def delete(input_id, key)
      @client.json_request(:delete, "/system/inputs/#{input_id}/staticfields/#{key}")
    end
  end
end
