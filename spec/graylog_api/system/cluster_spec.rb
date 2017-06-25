require 'pry'
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
      expect(response.keys).to include 'cluster_id'
    end

    it 'contain node_id' do
      expect(response.keys).to include 'node_id'
    end
  end

  context 'nodes' do
    subject(:response) do
      graylogapi.system.cluster.nodes
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain nodes' do
      expect(response.keys).to include 'nodes'
    end

    it 'contain count' do
      expect(response.keys).to include 'total'
    end
  end

  context 'node_by_id' do
    subject(:response) do
      graylogapi.system.cluster.node_by_id(node['node_id'])
    end

    let(:node) { graylogapi.system.cluster.node }

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain node_id' do
      expect(response['node_id']).to eq node['node_id']
    end
  end
end
