describe GraylogAPI::Users, vcr: true do
  include_context 'graylogapi'

  context 'get tokens of a user' do
    subject(:response) do
      graylogapi.users.tokens('admin')
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain tokens' do
      expect(response.body.keys).to include 'tokens'
    end
  end

  context 'create token for a user' do
    subject(:response) do
      res = graylogapi.users.create_token('admin', 'test')
      graylogapi.users.delete_token('admin', res['token'])
      res
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain name' do
      expect(response['name']).to eq 'test'
    end

    it 'contain token' do
      expect(response.keys).to include 'token'
    end
  end

  context 'remove token for a user' do
    subject(:response) do
      token = graylogapi.users.create_token('admin', 'test')['token']
      graylogapi.users.delete_token('admin', token)
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end
end
