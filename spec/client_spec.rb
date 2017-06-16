describe 'client' do
  include_context 'client'

  it 'should have base_uri' do
    expect(client.class.base_uri).to eq 'http://localhost:9000/api'
  end

  it 'should have username' do
    expect(client.class.default_options[:basic_auth][:username]).to eq 'admin'
  end

  it 'should have password' do
    expect(client.class.default_options[:basic_auth][:password]).to eq 'admin'
  end
end
