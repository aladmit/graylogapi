describe GraylogAPI::System, vcr: true do
  include_context 'graylogapi'

  context 'overview' do
    subject(:response) do
      graylogapi.system.overview
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain node_id' do
      expect(response.body.keys).to include 'node_id'
    end
  end
end
