describe GraylogAPI::System::IndexSets, vcr: true do
  include_context 'graylogapi'

  let(:options) do
    {
      title: 'Index set', index_prefix: 'prefix', shards: 4, replicas: 0,
      rotation_strategy_class: 'org.graylog2.indexer.rotation.strategies.MessageCountRotationStrategy',
      rotation_strategy: {
        type: 'org.graylog2.indexer.rotation.strategies.MessageCountRotationStrategyConfig',
        max_docs_per_index: 20000000
      },
      retention_strategy_class: 'org.graylog2.indexer.retention.strategies.DeletionRetentionStrategy',
      retention_strategy: {
        type: 'org.graylog2.indexer.retention.strategies.DeletionRetentionStrategyConfig',
        max_number_of_indices: 20
      },
      creation_date: '2017-06-20T10:32:10.89Z', index_analyzer: 'standard',
      index_optimization_max_num_segments: 1, index_optimization_disabled: false,
      writable: true
    }
  end

  context 'get all index sets' do
    subject(:response) { graylogapi.system.index_sets.all }

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have count of index sets' do
      expect(response.body.keys).to include 'total'
    end

    it 'have index sets' do
      expect(response.body.keys).to include 'index_sets'
    end

    it 'have stats' do
      expect(response.body.keys).to include 'stats'
    end
  end

  context 'create index set' do
    subject(:response) do
      graylogapi.system.index_sets.create(options)
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.body.keys).to include 'id'
    end

    it 'have title' do
      expect(response.body['title']).to eq options[:title]
    end
  end

  context 'get index set by id' do
    subject(:response) { graylogapi.system.index_sets.by_id(index_set['id']) }

    let(:index_set) { graylogapi.system.index_sets.all.body['index_sets'].first }

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.body['id']).to eq index_set['id']
    end

    it 'have title' do
      expect(response.body['title']).to eq index_set['title']
    end
  end

  context 'update index set' do
    subject(:response) do
      graylogapi.system.index_sets.update(index_set.body['id'], options)
    end

    let(:index_set) { graylogapi.system.index_sets.create(options) }

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.body['id']).to eq index_set.body['id']
    end

    it 'have title' do
      expect(response.body['title']).to eq index_set.body['title']
    end
  end

  context 'delete index set' do
    subject(:response) do
      graylogapi.system.index_sets.delete(index_set.body['id'])
    end

    let(:index_set) { graylogapi.system.index_sets.create(optinos) }

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end

  context 'set as default' do
    subject(:response) do
      graylogapi.system.index_sets.set_default(options.body['id'])
    end

    let(:index_set) { graylogapi.system.index_sets.create(options) }

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.body['id']).to eq index_set.body['id']
    end

    it 'have title' do
      expect(response.body['title']).to eq index_set.body['title']
    end

    it 'default' do
      expect(response.body['default']).to eq true
    end
  end
end
