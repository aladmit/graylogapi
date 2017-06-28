class GraylogAPI
  class StaticFields
    def initialize(client)
      @client = client
    end

    def create(input_id, params)
      @client.json_request(:post, "/system/inputs/#{input_id}/staticfields", params)
    end

    def delete(input_id, key)
      @client.json_request(:delete, "/system/inputs/#{input_id}/staticfields/#{key}")
    end
  end
end
