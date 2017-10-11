describe GraylogAPI::System::Inputs::Types, vcr: true do
  include_context 'graylogapi'

  context 'node' do
    subject(:response) do
      graylogapi.system.inputs.types.node
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain types' do
      expect(response.keys).to include 'types'
    end
  end

  context 'all' do
    subject(:response) do
      graylogapi.system.inputs.types.all
    end

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain types' do
      expect(response.keys).to include 'org.graylog2.inputs.syslog.udp.SyslogUDPInput'
    end
  end

  context 'get input by type' do
    subject(:response) do
      graylogapi.system.inputs.types.by_type(type)
    end

    let(:type) { 'org.graylog2.inputs.syslog.udp.SyslogUDPInput' }
    let(:name) { 'Syslog UDP' }

    it 'code 200' do
      expect(response.code).to eq 200
    end

    it 'contain type' do
      expect(response['type']).to eq type
    end

    it 'contain name' do
      expect(response['name']).to eq name
    end
  end

  context 'converge type_id to type_name' do
    subject(:response) do
      graylogapi.system.inputs.types.type_to_name(type)
    end

    let(:type) { 'org.graylog2.inputs.syslog.udp.SyslogUDPInput' }
    let(:name) { 'Syslog UDP' }

    it 'return type name' do
      expect(response).to eq name
    end
  end
end
