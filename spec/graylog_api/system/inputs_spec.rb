describe GraylogAPI::System::Inputs, vcr: true do
  include_context 'graylogapi'

  context 'create input' do
    subject(:response) do
      options = { title: 'Test_create_input',
                  type: 'org.graylog.plugins.beats.BeatsInput',
                  global: true,
                  configuration: { bind_address: '0.0.0.0',
                                   port: 5044,
                                   recv_buffer_size: 1_048_576,
                                   tls_client_auth: 'disabled' } }
      graylogapi.system.inputs.create(options)
    end

    it 'code 201' do
      expect(response.code).to eq 201
    end

    it 'return id' do
      expect(response.body.keys).to contain_exactly 'id'
    end
  end

  context 'update input' do
    subject(:response) do
      options = { title: 'Input by gem123',
                  type: 'org.graylog.plugins.beats.BeatsInput',
                  global: true,
                  configuration: { bind_address: '0.0.0.0',
                                   port: 5044 } }

      input = graylogapi.system.inputs.create(options)
      graylogapi.system.inputs.update(input.body['id'], options)
    end

    it 'code 201' do
      expect(response.code).to eq 201
    end

    it 'return id' do
      expect(response.body.keys).to contain_exactly 'id'
    end
  end

  context 'get all inputs' do
    subject(:response) { graylogapi.system.inputs.all }

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain count of inputs' do
      expect(response.body.keys).to include 'total'
    end

    it 'contain array of inputs' do
      expect(response.body.keys).to include 'inputs'
    end
  end

  context 'get by id' do
    subject(:response) do
      options = { title: 'Input by gem123',
                  type: 'org.graylog.plugins.beats.BeatsInput',
                  global: true,
                  configuration: { bind_address: '0.0.0.0',
                                   port: 5044 } }

      input = graylogapi.system.inputs.create(options)
      graylogapi.system.inputs.by_id(input.body['id'])
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain id' do
      expect(response.body.keys).to include 'id'
    end

    it 'contain title' do
      expect(response.body.keys).to include 'title'
    end
  end
end
