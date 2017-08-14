require 'securerandom'

describe GraylogAPI::System::IndexSets, vcr: true do
  include_context 'graylogapi'

  let(:options) do
    {
      title: 'Index set',
      index_prefix: 'test',
      shards: 4,
      replicas: 0,
      rotation_strategy_class: 'org.graylog2.indexer.rotation.strategies.MessageCountRotationStrategy',
      rotation_strategy: {
        type: 'org.graylog2.indexer.rotation.strategies.MessageCountRotationStrategyConfig',
        max_docs_per_index: 20_000_000
      },
      retention_strategy_class: 'org.graylog2.indexer.retention.strategies.DeletionRetentionStrategy',
      retention_strategy: {
        type: 'org.graylog2.indexer.retention.strategies.DeletionRetentionStrategyConfig',
        max_number_of_indices: 20
      },
      creation_date: '2017-06-20T10:32:10.89Z',
      index_analyzer: 'standard',
      index_optimization_max_num_segments: 1,
      index_optimization_disabled: false,
      writable: true
    }
  end

  context 'get all index sets' do
    subject(:response) { graylogapi.system.index_sets.all }

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have count of index sets' do
      expect(response.keys).to include 'total'
    end

    it 'have index sets' do
      expect(response.keys).to include 'index_sets'
    end

    it 'have stats' do
      expect(response.keys).to include 'stats'
    end
  end

  context 'create index set' do
    subject(:response) do
      create_options = options.dup
      title = generate_string
      create_options[:title] = title
      create_options[:index_prefix] = title
      req = graylogapi.system.index_sets.create(create_options)
      sleep 1
      graylogapi.system.index_sets.delete(req['id'])
      req
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.keys).to include 'id'
    end
  end

  context 'get index set by id' do
    subject(:response) do
      create_options = options.dup
      title = generate_string
      create_options[:title] = title
      create_options[:index_prefix] = title
      index_set = graylogapi.system.index_sets.create(create_options)
      req = graylogapi.system.index_sets.by_id(index_set['id'])
      sleep 1
      graylogapi.system.index_sets.delete(index_set['id'])
      req
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'have id' do
      expect(response.keys).to include 'id'
    end

    it 'have title' do
      expect(response.keys).to include 'title'
    end
  end

  context 'update index set' do
    subject(:response) do
      create_options = options.dup
      update_options = options.dup
      title = generate_string
      create_options[:title] = title
      create_options[:index_prefix] = title
      index_set = graylogapi.system.index_sets.create(create_options)
      update_options[:retention_strategy][:max_number_of_indices] = 10
      update_options[:title] = 'Updated title'
      sleep 1
      req = graylogapi.system.index_sets.update(index_set['id'], update_options)
      sleep 1
      graylogapi.system.index_sets.delete(index_set['id'])
      req
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'title changed' do
      expect(response['title']).to eq 'Updated title'
    end

    it 'max number of indices changed' do
      expect(response['retention_strategy']['max_number_of_indices']).to eq 10
    end
  end

  context 'set default index set' do
    subject(:response) do
      create_options = options.dup
      title = generate_string
      create_options[:title] = title
      create_options[:index_prefix] = title
      index_set = graylogapi.system.index_sets.create(create_options)
      req = graylogapi.system.index_sets.make_default(index_set['id'])
      sleep 1
      index_sets = graylogapi.system.index_sets.all
      graylogapi.system.index_sets.make_default(index_sets['index_sets'].first['id'])
      sleep 1
      graylogapi.system.index_sets.delete(index_set['id'])
      req
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'is default' do
      expect(response['default']).to eq true
    end
  end

  context 'delete index set' do
    subject(:response) do
      create_options = options.dup
      title = generate_string
      create_options[:title] = title
      create_options[:index_prefix] = title
      index_set = graylogapi.system.index_sets.create(create_options)
      sleep 1
      graylogapi.system.index_sets.delete(index_set['id'])
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end
end
