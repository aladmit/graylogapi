describe 'client' do
  include_context 'client'

  it 'should have base_uri' do
    expect(client.class.base_uri).to eq 'http://localhost:9000/api'
  end

  it 'should have username' do
    expect(client_defaults[:basic_auth][:username]).to eq 'admin'
  end

  it 'should have password' do
    expect(client_defaults[:basic_auth][:password]).to eq 'admin'
  end

  it 'use application/json type' do
    expect(client_defaults[:headers]['Content-Type']).to eq 'application/json'
  end
end
