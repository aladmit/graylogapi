class GraylogAPI
  # class for manage users
  class Users
    def initialize(client)
      @client = client
    end

    # Retrieves the list of access tokens for a user
    def tokens(username)
      @client.request(:get, "/users/#{username}/tokens")
    end

    # Generate a new access token for a user
    def create_token(username, name)
      @client.request(:post, "/users/#{username}/tokens/#{name}", {})
    end

    # Removes a token for a user
    def delete_token(username, name)
      @client.request(:delete, "/users/#{username}/tokens/#{name}")
    end
  end
end
