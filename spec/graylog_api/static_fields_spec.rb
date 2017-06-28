describe GraylogAPI::StaticFields, vcr: true do
  include_context 'graylogapi'

  let(:input_options) do
    {
      title: 'static_fields_input',
      type: 'org.graylog.plugins.beats.BeatsInput',
      global: true,
      configuration: { bind_address: '0.0.0.0',
                       port: 5044,
                       recv_buffer_size: 1_048_576,
                       tls_client_auth: 'disabled' }
    }
  end

  context 'create' do
    subject(:response) do
      input = graylogapi.system.inputs.create(input_options)
      res = graylogapi.static_fields.create(input['id'], key: 'static_key', value: 'value')
      graylogapi.static_fields.delete(input['id'], 'static_key')
      graylogapi.system.inputs.delete(input['id'])
      res
    end

    it 'code 201' do
      expect(response.code).to eq 201
    end
  end

  context 'delete' do
    subject(:response) do
      input = graylogapi.system.inputs.create(input_options)
      graylogapi.static_fields.create(input['id'], key: 'static_key', value: 'value')
      res = graylogapi.static_fields.delete(input['id'], 'static_key')
      graylogapi.system.inputs.delete(input['id'])
      res
    end

    it 'code 204' do
      expect(response.code).to eq 204
    end
  end
end
