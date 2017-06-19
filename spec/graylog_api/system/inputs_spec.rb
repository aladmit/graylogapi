describe GraylogAPI::System::Inputs, vcr: true do
  include_context 'graylogapi'

  context 'create input' do
    subject do
      graylogapi.system.inputs.create(title: 'Test_create_input',
                                      type: 'org.graylog.plugins.beats.BeatsInput',
                                      global: true,
                                      configuration: { bind_address: '0.0.0.0',
                                                       port: 5044,
                                                       recv_buffer_size: 1048576,
                                                       tls_client_auth: 'disabled' })
    end

    it 'code 201' do
      expect(subject.code).to eq 201
    end

    it 'return id' do
      expect(subject.body.keys).to contain_exactly 'id'
    end
  end

  context 'update input' do
    subject do
      options = { title: 'Input by gem123',
                  type: 'org.graylog.plugins.beats.BeatsInput',
                  global: true,
                  configuration: { bind_address: '0.0.0.0',
                                   port: 5044 } }

      input = graylogapi.system.inputs.create(options)
      graylogapi.system.inputs.update(input.body['id'], options)
    end

    it 'code 201' do
      expect(subject.code).to eq 201
    end

    it 'return id' do
      expect(subject.body.keys).to contain_exactly 'id'
    end
  end
end
