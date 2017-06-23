describe GraylogAPI::Streams, vcr: true do
  include_context 'graylogapi'

  let(:index_id) { graylogapi.system.index_sets.all.body['index_sets'].find { |i| i['title'] == 'Default index set' }['id'] }

  context 'create stream' do
    subject(:response) do
      req = graylogapi.streams.create(title: 'test', index_set_id: index_id, rules: [])
      graylogapi.streams.delete(req.body['id'])
      req
    end

    it 'code 201' do
      expect(response.code).to eq 201
    end

    it 'have stream_id' do
      expect(response.body.keys).to include 'stream_id'
    end
  end

  context 'delete stream' do
    subject(:response) do
      stream = graylogapi.streams.create(title: 'test', index_set_id: index_id, rules: [])
      graylogapi.streams.delete(stream.body['id'])
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end
end
