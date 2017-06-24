describe GraylogAPI::Client::Response, vcr: true do
  include_context 'graylogapi'

  subject(:response) { graylogapi.client.json_request(:get, '/') }

  it 'have code' do
    expect(response.code.class).to eq Fixnum
  end

  it 'have body' do
    expect(response.body.class).to eq Hash
  end

  it 'get field like hash' do
    expect(response['cluster_id']).to eq response.body['cluster_id']
  end
end
