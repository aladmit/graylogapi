describe GraylogAPI::Streams, vcr: true do
  include_context 'graylogapi'

  let(:index_id) { graylogapi.system.index_sets.all.body['index_sets'].find { |i| i['title'] == 'Default index set' }['id'] }

  context 'get all streams' do
    subject(:response) do
      graylogapi.streams.all
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have total count' do
      expect(response.body.keys).to include 'total'
    end

    it 'have streams' do
      expect(response.body.keys).to include 'streams'
    end
  end

  context 'create stream' do
    subject(:response) do
      req = graylogapi.streams.create(title: 'test', index_set_id: index_id, rules: [])
      graylogapi.streams.delete(req.body['stream_id'])
      req
    end

    it 'code 201' do
      expect(response.code).to eq 201
    end

    it 'have stream_id' do
      expect(response.body.keys).to include 'stream_id'
    end
  end

  context 'enabled streams' do
    subject(:response) do
      graylogapi.streams.enabled
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have total' do
      expect(response.body.keys).to include 'total'
    end

    it 'have streams' do
      expect(response.body.keys).to include 'streams'
    end
  end

  context 'get stream by id' do
    subject(:response) do
      req = graylogapi.streams.by_id(stream.body['id'])
      graylogapi.streams.delete(stream.body['id'])
      req
    end

    let(:stream) do
      graylogapi.streams.create(title: 'test', index_set_id: index_id, rules: [])
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.body['id']).to eq stream.body['id']
    end

    it 'have title' do
      expect(response.body['title']).to eq stream.body['title']
    end
  end

  context 'update stream' do
    subject(:response) do
      req = graylogapi.streams.update(stream.body['stream_id'], title: 'test2')
      graylogapi.streams.delete(stream.body['stream_id'])
      req
    end

    let(:stream) do
      graylogapi.streams.create(title: 'test', index_set_id: index_id, rules: [])
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.body['id']).to eq stream.body['stream_id']
    end

    it 'have title' do
      expect(response.body['title']).to eq 'test2'
    end
  end

  context 'delete stream' do
    subject(:response) do
      stream = graylogapi.streams.create(title: 'test', index_set_id: index_id, rules: [])
      graylogapi.streams.delete(stream.body['stream_id'])
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end

  context 'clone stream' do
    subject(:response) do
      created = graylogapi.streams.create(title: 'created', index_set_id: index_id)
      cloned = graylogapi.streams.clone(created.body['stream_id'], title: 'cloned', description: '', index_set_id: index_id)
      graylogapi.streams.delete(created.body['stream_id'])
      graylogapi.streams.delete(cloned.body['stream_id'])
      cloned
    end

    it 'code 201' do
      expect(response.code).to eq 201
    end

    it 'have stream_id' do
      expect(response.body.keys).to include 'stream_id'
    end
  end

  context 'pause stream' do
    subject(:response) do
      stream = graylogapi.streams.create(title: 'pause', index_set_id: index_id)
      req = graylogapi.streams.pause(stream.body['stream_id'])
      graylogapi.streams.delete(stream.body['stream_id'])
      req
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end

  context 'resume stream' do
    subject(:response) do
      stream = graylogapi.streams.create(title: 'resume', index_set_id: index_id)
      req = graylogapi.streams.resume(stream.body['stream_id'])
      graylogapi.streams.delete(stream.body['stream_id'])
      req
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end
end
