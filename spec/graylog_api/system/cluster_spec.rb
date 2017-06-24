describe GraylogAPI::System::Cluster, vcr: true do
  include_context 'graylogapi'

  context 'node' do
    subject(:response) do
      graylogapi.system.cluster.node
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain cluster_id' do
      expect(response.body.keys).to include 'cluster_id'
    end

    it 'contain node_id' do
      expect(response.body.keys).to include 'node_id'
    end
  end
end
