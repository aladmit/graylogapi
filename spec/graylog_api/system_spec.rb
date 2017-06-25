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
      expect(response.keys).to include 'node_id'
    end
  end

  context 'jvm information' do
    subject(:response) do
      graylogapi.system.jvm
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain node_id' do
      expect(response.keys).to include 'node_id'
    end

    it 'contain used_memory' do
      expect(response.keys).to include 'used_memory'
    end
  end

  context 'thread dump' do
    subject(:response) do
      graylogapi.system.thread_dump
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain thread dump' do
      expect(response.keys).to include 'threaddump'
    end
  end
end
